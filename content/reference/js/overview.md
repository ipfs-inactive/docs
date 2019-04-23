---
title: "Working with IPFS in JS"
menu:
    reference:
        parent: js_implementation
        weight: 1
---

There are two main JavaScript libraries for working with IPFS. Both work in Node.js and in modern web browsers:

- **[`js-ipfs`](https://github.com/ipfs/js-ipfs)** is a full implementation of IPFS, similar to [`go-ipfs`](https://github.com/ipfs/go-ipfs). You can use it either as a command-line application or as a library to start an IPFS node directly in your program.

- **[`js-ipfs-http-client`](https://github.com/ipfs/js-ipfs-http-client)** is a smaller library that controls an IPFS node that is already running via its [HTTP API](/api/http). `js-ipfs` actually uses this library internally if it detects that another node is already running on your computer. You can also interact with the [HTTP API](/api/http) directly using `fetch()` in a browser or a module like `request` in Node.js, but using this library can be much more convenient.

Both libraries have the same [interface for using all the major IPFS commands](https://github.com/ipfs/interface-ipfs-core/tree/master/SPEC).

Whenever reasonable, we recommend the second method (interacting with a separate IPFS node via the HTTP API). Keeping the IPFS node in a separate process (even if it’s one your program spawns) isolates you from any stability problems with the node. If a user already has IPFS installed, this also means you can take advantage of a single, common installation on their computer. It’s also less code to load in a browser. If you need to spawn a separate IPFS process, you might want to take a look at [`js-ipfsd-ctl`](https://github.com/ipfs/js-ipfsd-ctl), which uses the same interface to spawn a `go-ipfs` node, a `js-ipfs` node, or an in-process `js-ipfs` node.


## IPFS in Web Browsers

Both the `js-ipfs` and `js-ipfs-http-client` libraries work in browsers, but each has some special considerations noted in their READMEs.

We are also building a browser extension named [IPFS Companion](https://github.com/ipfs-shipyard/ipfs-companion). If a visitor to your site has it installed, it will make a global [`window.ipfs`](https://github.com/ipfs-shipyard/ipfs-companion/blob/5d793ece81ec13e200f76a27d656688981740f13/docs/window.ipfs.md) object available to your JavaScript. This object has the same interface as `js-ipfs-api`, but comes with much better security controls and lets you use IPFS without loading any special libraries.
