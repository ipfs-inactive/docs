SHELL=/bin/bash
DOMAIN="ipfs.io"

IPFSLOCAL="http://localhost:8080/ipfs/"
IPFSGATEWAY="https://ipfs.io/ipfs/"
NPM=npm
NPMBIN=./node_modules/.bin
OUTPUTDIR=public
PKGDIR=content/reference/pkg
PORT=1313

ifeq ($(DEBUG), true)
	PREPEND=
	APPEND=
else
	PREPEND=@
	APPEND=1>/dev/null
endif

# Where Hugo should be installed locally
HUGO_LOCAL=./bin/hugo
# Path to Hugo binary to use when building the site
HUGO_BINARY=$(HUGO_LOCAL)
HUGO_VERSION=0.45.1
PLATFORM:=$(shell uname)
ifeq ('$(PLATFORM)', 'Darwin')
	PLATFORM=macOS
endif
MACH:=$(shell uname -m)
ifeq ('$(MACH)', 'x86_64')
	MACH=64bit
else
	MACH=32bit
endif
HUGO_URL="https://github.com/gohugoio/hugo/releases/download/v$(HUGO_VERSION)/hugo_$(HUGO_VERSION)_$(PLATFORM)-$(MACH).tar.gz"


node_modules:
	$(PREPEND)$(NPM) install $(APPEND)

ipfs-theme:
	$(PREPEND)[ -d build/assets/fonts ] || mkdir -p build/assets/fonts
	$(PREPEND)cp ./node_modules/ipfs-css/fonts/Montserrat* ./build/assets/fonts/ $(APPEND)
	$(PREPEND)cp ./node_modules/ipfs-css/fonts/Inter-UI* ./build/assets/fonts/ $(APPEND)
	$(PREPEND)node scripts/ipfs-css-constants.js $(APPEND)

packages:
	# The JS packages don't actually generate useful docs right now, so skip them
	# $(PREPEND)scripts/pkg2md.sh github.com/ipfs/js-ipfs-api master $(PKGDIR) pkg
	# $(PREPEND)scripts/pkg2md.sh github.com/ipfs/js-ipfs master $(PKGDIR) pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs-api v1.2.1 $(PKGDIR) go/pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs/core/coreapi v0.4.15 $(PKGDIR) go/pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs/core/coreapi/interface v0.4.15 $(PKGDIR) go/pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs/core/coreapi/interface/options v0.4.15 $(PKGDIR) go/pkg

bin/hugo:
	@echo "Installing Hugo to $(HUGO_LOCAL)..."
	$(PREPEND)mkdir -p tmp_hugo $(APPEND)
	$(PREPEND)curl --location "$(HUGO_URL)" | tar -xzf - -C tmp_hugo && chmod +x tmp_hugo/hugo && mv tmp_hugo/hugo $(HUGO_LOCAL) $(APPEND)
	$(PREPEND)rm -rf tmp_hugo $(APPEND)

resources: ipfs-theme packages

install: bin/hugo node_modules resources

css:
	# Dual calls to less because there seems to be a bug with multiple plugins in v3 :(
	# https://github.com/less/less.js/issues/3187
	$(PREPEND)$(NPMBIN)/lessc -clean-css --autoprefix src/styles/main.less build/assets/main.css $(APPEND)

js:
	$(PREPEND)$(NPMBIN)/browserify src/js/main.js -o build/assets/main.js --debug $(APPEND)

minify-js: js
	$(PREPEND)$(NPMBIN)/uglifyjs --compress --output build/assets/main.js -- build/assets/main.js $(APPEND)

lint:
	$(NPMBIN)/standard src/js/**/*.js

build: clean install lint css js minify-js
	$(PREPEND)$(HUGO_BINARY) && \
	echo "" && \
	echo "Site built out to ./$(OUTPUTDIR)"

dev: css
	$(PREPEND)( \
		$(NPMBIN)/nodemon --watch src/styles --ext less,css --exec "$(NPMBIN)/lessc -clean-css --autoprefix src/styles/main.less build/assets/main.css" & \
		$(NPMBIN)/watchify src/js/main.js -o build/assets/main.js --debug & \
		$(HUGO_BINARY) server -w --port $(PORT) --bind 0.0.0.0 \
	)

serve:
	$(PREPEND)$(HUGO_BINARY) server

deploy:
	export hash=`ipfs add -r -Q $(OUTPUTDIR)`; \
		echo ""; \
		echo "published website:"; \
		echo "- $(IPFSLOCAL)$$hash"; \
		echo "- $(IPFSGATEWAY)$$hash"; \
		echo ""; \
		echo "next steps:"; \
		echo "- ipfs pin add -r /ipfs/$$hash"; \
		echo "- make publish-to-domain"

clean:
	$(PREPEND)[ ! -d $(OUTPUTDIR) ] || rm -rf $(OUTPUTDIR)
	$(PREPEND)[ ! -d $(PKGDIR) ] || rm -rf $(PKGDIR)/*/
	$(PREPEND)[ ! -d build/assets ] || rm -rf build/assets/*

.PHONY: packages build help deploy publish-to-domain clean
