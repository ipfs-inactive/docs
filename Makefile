SHELL=/bin/bash

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

build: clean install lint css js minify-js
	$(PREPEND)$(NPMBIN)/hugo && \
	echo "" && \
	echo "Site built out to ./public dir"

node_modules:
	$(PREPEND)$(NPM) install $(APPEND)

ipfs-theme:
	$(PREPEND)[ -d build/assets/fonts ] || mkdir -p build/assets/fonts
	$(PREPEND)cp ./node_modules/ipfs-css/fonts/Montserrat* ./build/assets/fonts/ $(APPEND)
	$(PREPEND)cp ./node_modules/ipfs-css/fonts/Inter-UI* ./build/assets/fonts/ $(APPEND)
	$(PREPEND)node scripts/ipfs-css-constants.js $(APPEND)

resources: ipfs-theme

install: node_modules resources

css:
	$(PREPEND)$(NPMBIN)/lessc -clean-css --autoprefix src/styles/main.less build/assets/main.css $(APPEND)

js:
	$(PREPEND)$(NPMBIN)/browserify src/js/main.js -o build/assets/main.js --debug $(APPEND)

minify-js: js
	$(PREPEND)$(NPMBIN)/uglifyjs --compress --output build/assets/main.js -- build/assets/main.js $(APPEND)

lint:
	$(NPMBIN)/standard src/js/**/*.js

lint-fix:
	$(NPMBIN)/standard src/js/**/*.js --fix

dev: css
	$(PREPEND)( \
		$(NPMBIN)/nodemon -q --watch src/styles --ext less,css --exec "$(NPMBIN)/lessc -clean-css --autoprefix src/styles/main.less build/assets/main.css" & \
		$(NPMBIN)/watchify src/js/main.js -o build/assets/main.js --debug & \
		$(NPMBIN)/hugo server -w --port $(PORT) --bind 0.0.0.0 \
	)

serve:
	$(PREPEND)$(NPMBIN)/hugo server

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

.PHONY: build help deploy publish-to-domain clean
