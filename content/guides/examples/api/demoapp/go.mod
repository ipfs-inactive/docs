module github.com/ipfs/docs/content/guides/examples/api/demoapp

go 1.12

replace github.com/dgraph-io/badger => github.com/dgraph-io/badger v1.6.0-rc1

require (
	github.com/ipfs/go-ipfs v0.4.21
	golang.org/x/net v0.0.0-20190628185345-da137c7871d7
)
