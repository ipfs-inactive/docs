SHELL=/bin/bash
DOMAIN="ipfs.io"

IPFSLOCAL="http://localhost:8080/ipfs/"
IPFSGATEWAY="https://ipfs.io/ipfs/"
NPM=npm
NPMBIN=./node_modules/.bin
OUTPUTDIR=public
PKGDIR=content/reference/pkg

ifeq ($(DEBUG), true)
	PREPEND=
	APPEND=
else
	PREPEND=@
	APPEND=1>/dev/null
endif

node_modules:
	$(PREPEND)$(NPM) install $(APPEND)

ipfs-theme:
	$(PREPEND)[ -d static/assets/fonts ] || mkdir -p static/assets/fonts
	$(PREPEND)cp ./node_modules/ipfs-css/fonts/Montserrat* ./static/assets/fonts/ $(APPEND)
	$(PREPEND)node scripts/ipfs-css-constants.js $(APPEND)

packages:
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/js-ipfs-api master $(PKGDIR) pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/js-ipfs master $(PKGDIR) pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs-api v1.2.1 $(PKGDIR) go/pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs/core/coreapi v0.4.15 $(PKGDIR) go/pkg

resources: ipfs-theme packages

install: node_modules resources

css:
	# Dual calls to less because there seems to be a bug with multiple plugins in v3 :(
	# https://github.com/less/less.js/issues/3187
	$(PREPEND)$(NPMBIN)/lessc --autoprefix src/styles/main.less static/assets/main.css && \
	$(NPMBIN)/lessc --clean-css static/assets/main.css static/assets/main.css $(APPEND)

build: clean packages css
	$(PREPEND)hugo && \
	echo "" && \
	echo "Site built out to ./$(OUTPUTDIR)"

dev: css
	$(PREPEND)( \
		$(NPMBIN)/nodemon --watch src/styles --ext less,css --exec "$(NPMBIN)/lessc --autoprefix src/styles/main.less static/assets/main.css && $(NPMBIN)/lessc --clean-css static/assets/main.css static/assets/main.css" & \
		hugo server -w \
	)

serve:
	$(PREPEND)hugo server

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
	$(PREPEND)[ ! -d static/assets ] || rm -rf static/assets/*

.PHONY: packages build help deploy publish-to-domain clean
