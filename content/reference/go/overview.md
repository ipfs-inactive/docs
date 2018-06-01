---
title: "Working with Go IPFS"
menu:
    reference:
        parent: go_implementation
        weight: 1
---

`go-ipfs` is the primary reference implementation of IPFS. It is a command-line application, but can also be used as a library in other Go programs.

For more about using the `ipfs` application, see [basic usage](/start/usage) or any of the following reference documents:

- [Configuration reference](https://github.com/ipfs/go-ipfs/blob/master/docs/config.md)
    - [Datastore configuration](https://github.com/ipfs/go-ipfs/blob/master/docs/datastores.md)
    - [Experimental features](https://github.com/ipfs/go-ipfs/blob/master/docs/experimental-features.md)
- [Installing command completion](https://github.com/ipfs/go-ipfs/blob/master/docs/command-completion.md)
- [Mounting IPFS with FUSE](https://github.com/ipfs/go-ipfs/blob/master/docs/fuse.md)
- [Installing plugins](https://github.com/ipfs/go-ipfs/blob/master/docs/plugins.md)

For more technical information about building, debugging or using the API, see:

- [Performance Debugging Guidelines](https://github.com/ipfs/go-ipfs/blob/master/docs/debug-guide.md)
- [IPFS API Implementation](https://github.com/ipfs/go-ipfs/blob/master/docs/implement-api-bindings.md)
- [Connecting with Websockets](https://github.com/ipfs/go-ipfs/blob/master/docs/transports.md)
- Building on…
    - [Windows](https://github.com/ipfs/go-ipfs/blob/master/docs/windows.md)
    - [OpenBSD](https://github.com/ipfs/go-ipfs/blob/master/docs/openbsd.md)
- Additional guides at: https://github.com/ipfs/go-ipfs/blob/master/docs/

If you plan to use `go-ipfs` as a package in your own Go application, you can take any of three main approaches:

- Use **[`go-ipfs`](https://github.com/ipfs/go-ipfs)** to run IPFS directly in your own process. See [the API reference](/go/pkg/go-ipfs/core/coreapi).
- Use **[`go-ipfs-api`](https://github.com/ipfs/go-ipfs-api)** to communicate with an IPFS daemon in a separate process via its HTTP API (this is what `go-ipfs` does if a daemon is already running). See [the API reference](/go/pkg/go-ipfs-api).
- Use other Go packages to communicate with the HTTP API directly. See the [HTTP API reference](/api/http).
