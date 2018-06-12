---
title: "UnixFS"
menu:
    guides:
        parent: concepts
---

A file in IPFS isn’t just content. It might be too big to fit in a single block, so it needs metadata to link all its blocks together. It might be a symlink or a directory, so it needs metadata to link to other files. UnixFS is the data format used to represent files and all their links and metadata in IPFS, and is loosely based on how files work in Unix. When you add a *file* to IPFS, you are creating a block (or a tree of blocks) in the UnixFS format.

UnixFS is a [protocol-buffers](https://developers.google.com/protocol-buffers/)-based format. You can find the definitions for it at: https://github.com/ipfs/go-ipfs/blob/master/unixfs/pb/unixfs.proto.

<!-- TODO: fill in and link to the UnixFS v1 spec or fill in more details about how it works here. -->

*Note: we are currently designing an updated version of UnixFS that will be [IPLD](https://ipld.io)-compatible. You can follow along or participate [on GitHub](https://github.com/ipfs/unixfs-v2).*
