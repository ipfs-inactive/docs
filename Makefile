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

packages:
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/js-ipfs-api master $(PKGDIR) pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/js-ipfs master $(PKGDIR) pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs-api v1.2.1 $(PKGDIR) go/pkg
	$(PREPEND)scripts/pkg2md.sh github.com/ipfs/go-ipfs/core/coreapi v0.4.15 $(PKGDIR) go/pkg

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
	$(PREPEND)[ ! -d $(PKGDIR) ] || rm -rf $(PKGDIR)/*/

.PHONY: packages build help deploy publish-to-domain clean
