---
title: "Content Identifiers (CIDs)"
menu:
    docs:
        parent: concepts
---

A *content identifier* is a value that addresses a single piece of content in IPFS. It is mainly a cryptographic hash of the content, but is encoded as a [multihash](https://github.com/multiformats/multihash) and [multicodec](https://github.com/multiformats/multicodec). (Note: older CIDs have a different design — see [version 0](#version-0) below.)

<!-- TODO: explain more of the details of how CID v1 is composed here. -->

You can read up on the details in the [CID spec](https://github.com/ipld/cid). You might also want to check out the [CID inspector](http://cid-utils.ipfs.team/#zb2rhiVd5G2DSpnbYtty8NhYHeDvNkPxjSqA7YbDPuhdihj9L) for an interactive breakdown of CIDs.

## Version 1

Version 1 is the latest version of CID. It is used by default for `files` ([MFS](/concepts/mfs)) and `object` operations.

## Version 0

When IPFS was first designed, we used base 58-encoded multihashes as the content identifiers. (This is simpler, but much less flexible than newer CIDs.) It is still used by default when adding files and blocks to IPFS, so you should generally try to support them.

The CID specification includes a [decoding algorithm](https://github.com/ipld/cid/blob/ef1b2002394b15b1e6c26c30545fd485f2c4c138/README.md#decoding-algorithm) you can use to distinguish CID v0 from newer versions.
