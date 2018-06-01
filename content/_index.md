---
type: index
title: IPFS Documentation
---

Welcome to the IPFS documentation portal! Whether you’re just learning about IPFS or are looking for detailed reference information, this is the place to start. You might have noticed that IPFS is a project with a big scope — and a *lot* of different tools, sites, and code.

## Introduction

Head over to the [introduction](/introduction) section for an introduction to the basics of IPFS and a guide to getting up and running.


## Guides

The guides section has an overview of major concepts in IPFS, guides, and example projects demonstrating various ways to use IPFS.

In particular, IPFS is a complex system that aims to change a lot of things about how we use the internet, so it naturally comes with a lot of new concepts. Check the [concepts](/guides/concepts) section to learn more about the major architectural pieces of IPFS and about terms and ideas associated with distributed filesystes.


## Reference

### Commands & API

If you are using IPFS via the [command line](/reference/api/cli) or [interacting with a running IPFS node](/reference/api/http) programmatically, you’ll use IPFS’s commands API. It’s implemented in both the Go and JavaScript versions of IPFS.


### Go & JavaScript Implementations

IPFS is fundamentally a set of protocols for communicating about a distributed system of files, but those protocols are informed by reference implementations in both [Go](/reference/go/overview) and [JavaScript](/reference/js/overview). The Go implemntation is more mature and implements more of the IPFS protocols, but the JS implementation can be used in a broader variety of requirements (including in web browsers).


### Specifications & Planning

While IPFS has two reference implementations (in Go and JavaScript), it is fundamentally a set of protocols for formatting and communicating about distributed filesystems. You can find specifications for those protocols, whitepapers, and information about our RFC (Request for Change) process in the “specifications & planning” section.


## Community

Get in touch with other members of the IPFS community who are building tools on top of IPFS or even helping to build IPFS itself! You can ask questions, discuss new ideas, or get support for problems at https://discuss.ipfs.io, but you can also [hop on IRC](/community/irc) for a quick chat.

See the other links in the community section for more information about meetings, events, apps people are building, and more.

Information about contributing to IPFS and about other software projects in the community are also hosted here.


### Applications

Both the Go and JavaScript implementations of IPFS are written to function as libraries and command-line applications with relatively restricted functionality. We are working on a variety of other applications that make use of IPFS, like GUI applications, browser extensions, and clustering tools for managing large data archives. You can find more about them here.


### Get Involved

IPFS is an open-source community project. While [Protocol Labs](https://protocol.ai) is able to sponsor some of the work around it, much of the design, code, and effort is contributed by volunteers and community members like you. If you’re interested in helping improve IPFS, check the [how to help](/community/contribute/how_to_help) guide to get started.

If you are diving in to contribute new code, make sure you check both the [contribution guidelines] and the style guide for your language ([Go](https://github.com/ipfs/community/blob/master/go-code-guidelines.md), [JavaScript](https://github.com/ipfs/community/blob/master/js-code-guidelines.md)).


### Related Projects

We’ve split out some of the major parts of IPFS into separate projects over time — while they’re still critical components of IPFS, they can be useful in a variety of other contexts, too. Check their individual sites for specific information and references:

- [Libp2p](https://libp2p.io) manages all the peer-to-peer networking parts of IFPS.
- [Multiformats](https://multiformats.io) is a variety of *self-describing* data formats.
- [IPLD](https://ipld.io) is a set of tools for describing links between content-addressed data, like IPFS files, Git commits, or Ethereum blocks.
