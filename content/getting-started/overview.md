+++
title = "Overview"
description = "The core concepts behind IPFS"
weight = 1
+++

The point of this document is to explain the core concepts behind IPFS.

## Content Addressing

The main feature of IPFS in adressing content based on what it is, not where it is. Unique and secure content adressing
is achieved by the use of cryptographic functions and data structures called merkle trees.

[[TODO: Expand / Explain benefits]]

## Multiformats

Multiformats can be summarized as "self-describing values for future-proofing". There are multiple ways this can be
applied

[[TODO: Links]]

* MultiBase - Self identifying base encodings
* MultiHash - Self describing hashes
* MultiAddr - Composable and future-proof network addresses
* MultiCodec - Compact self-describing codecs
* MultiStream - Self describing streams

[[TODO: A bit more on topic]]

## Content Identifiers

Content Identifiers - CIDs - Are the way data is adressed in IPFS. There are two main kinds of them in use currently:

### CIDv1
CIDv1 is a multibase encoded string identyfing the content it's pointing to with a multicodec and a multihash

```
<cidv1> ::= <multibase-prefix><cid-version><multicodec-packed-content-type><multihash-content-address>
```

### CIDv0
[[TODO: do]]

## UnixFS - files
UnixFS is one of the interfaces that can be used to interface with IPFS (the other one is IPLD). It is based on the
idea of files.

[[TODO: Expand]]

## IPLD - data
IPLD - InterPlanetary Linked Data, which can be accessed with the `dag` API is the other interface to IPFS. It's main
adventage is the ability to adress data across different merkle-tree-compatible data formats.

[[TODO: Expand]]

[[TODO: Make sure not to introduce too much confusion here]]
