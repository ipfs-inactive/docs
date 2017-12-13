SHELL=/bin/bash
DOMAIN="ipfs.io"

IPFSLOCAL="http://localhost:8080/ipfs/"
IPFSGATEWAY="https://ipfs.io/ipfs/"
NPM=npm
NPMBIN=./node_modules/.bin
OUTPUTDIR=public

ifeq ($(DEBUG), true)
	PREPEND=
	APPEND=
else
	PREPEND=@
	APPEND=1>/dev/null
endif

packages:
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/js-ipfs-api master content/reference/pkg pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/js-ipfs master content/reference/pkg pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs-api master content/reference/pkg pkg

build: clean packages
	$(PREPEND)hugo && \
	echo "" && \
	echo "Site built out to ./$(OUTPUTDIR)"

serve:
	$(PREPEND)hugo server

node_modules:
	$(PREPEND)$(NPM) i $(APPEND)

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

.PHONY: packages build help deploy publish-to-domain clean
