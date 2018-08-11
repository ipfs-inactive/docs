---
title: "Node"
menu:
    guides:
        parent: concepts
---

## Summary

An IPFS node is, generally, an instance of the IPFS software.  People run IPFS nodes for storing their own content (see [Pinning](/concepts/pinning)) and other content that may be found in the IPFS network (on nodes run by others).

The IPFS node software takes care of sharing content with other nodes.  It shares and maintains an index of which data it, and its neighbor nodes (peers), are storing. 

When a person requests a piece of content from IPFS, the node works to find that content and provide it to the requestor. Often this request is initiated by a web browser, through an HTTP gateway running in the same process.

## Ambiguity

"IPFS node" generally refers to the software running the IPFS program, as described above.  This same process may also be running additional services, such as an HTTP gateway or Libp2p.

There can be other usages of the term "node", but these distinctions are generally well labeled and important only in a more technical context. 
