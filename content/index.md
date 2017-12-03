---
type: index
title: "Addressing on the Decentralized Web"
---

> Note: This document is work in progress and largely incomplete.

Authors: Lars Gierth \<lgierth@ipfs.io>


## Introduction

Location-based addressing is a centralizing vector on the web.
It lets links rot and drives copies of content into mutual competition.

This document describes a content-based addressing model
which provides permanent links that don't rot and are cryptographically verifiable.
The result is a more cooperative, resilient, and performant web.


## The fragmented web

- walled gardens, facebook you-are-now-leaving-the-facebook-sector warnings, free basics
- many kinds of fragmentation on many layers [slate], we'll discuss specific kinds
- content that falls off the internet (domain owner change, link structure change, acquisition, censorship)
- content that has copies in many locations, which are all hidden in favor of the original address
- lack of content integrity
- lack of a concept of changing content. it changes regardless.

- ownership
  - location-addressing gives control over data to those entities who already have enough resources for server + bandwidth + domain + certificates
    - control its liveness through hosting it (whether it's allowed to continue to exist and be available)
      - and through not being able to address replicated copies in the network
    - control its truth, by controlling the request path
  - location-addressing ties linked content to only to one entity, but also to exactly one transport mechanism
    - this is part of the addressing rift
    - huge liability of not being able to upgrade and mix transports

- history of the url shows you have only very small window (~2yrs) for fundamental changes



### Link competition and link rot

- borrow from matt https://github.com/ipfs/blog/pull/117
- geocities
- large datasets
  - especially those that are already endangered :(
- figure out how large to quote https://eager.io/blog/the-history-of-the-url-path-fragment-query-auth/



### The addressing rift

- location-addressing doesn't just

the rift web (uri) vs. os (fs) vs. databases (sql)
- plan9 everything-is-a-file is nice
- fuse is nice
- ipfs aims to reunite fs and web

- example of the rift
- example of what we're missing out on currently

- if we had URIs instead of multiaddr
- p2p+tcp://bootstrap.libp2p.io/QmFoo
  1. it doesn't fit the resource-on-server model
  2. there's too many protocol combinations to have one URI scheme for each
- church of context vs. church of self-description


## DWeb Addressing

At the heart of this proposal lies the desire to decouple data from its network location.

- great quote in http://1997.webhistory.org/www.lists/www-talk.1993q2/0234.html
- tons of great things in https://eager.io/blog/the-history-of-the-url-path-fragment-query-auth/

- hourglass model
- osi model
- need a data thin waist (=> ipld) in addition to network thin waist
  - why again?


## Namespaces

- syntax
- local filesystem examples


### /ipfs -- immutable data

- cid
- unixfs
- ipld

- example: expose only /ipfs to a container


### /ipns -- mutable names

- ipns
- dnslink
- proquint


### Integration with other content-addressed systems

- want to collaborate with all groups working on content-addressed stuff
- how /ipfs and /ipfs fit in with other-type schemes in one universal namespace

- /git /eth /btc /zcash /torrent /dat

- mention /ipld?
- mention /did? probably not yet (@jonnycrunch)
- mention /iptf? probably not yet
- don't mention: Historic namespaces: /dns


### Network addressing

- reiterate why we decouple content from location
- show multiaddr


## Interoperability

- explain concept of upgrade path


### DWeb Addressing with HTTP

- gateway semantics
  - caching
  - directory redirect
  - directory index
  - custom 404
  - writable gateway
- CSP: quasi-browser vs. subdomains
- suborigins


### ipfs:// and ipns:// URL schemes

- syntax
- security model
- base32 conversions


### dweb: URI scheme

We're not trying to bring in all the possible sources of data, or interfaces, etc.
We only work on content-addressed stuff here.
But we do think paths are the better canonical address and that
all kinds of things with different semantics can live in a shared universal namespace.


### Content Security Policy / Origins

Pluggable origins? would make this a bit easier. suborigins step in right direction

How to detect and intercept http-to-ipfs URLs in documents
- Simply /ipfs/* and /ipns/*?
- $hash.ipfs.somedomain ?
- could have links in document to //qmfoo.ipfs.dweb.link (http://) and //qmfoo (ipfs://)


## Appendix


### Related work

- IPFS: peer-to-peer hypermedia protocol
- IPLD: data model of the content-addressable web
- dnslink: human-readable IPNS names


### FAQ

But Lars, why path namespaces and a dweb: URI scheme, why not just only ipfs:// and ipns://?
- These URLs satisfy the content-addressing requirement
- They don't satisfy the universal-data-namespace requirement
- We want to leave room for others in this new addressing scheme

But Lars, you can achieve all this realtime/replication/verification stuff with existing tools and protocols!
- Sure, but these setups would be on an individual basis, brittle, and even more fragmented
- What we're missing is a protocol that is built around these core requirements

How does content-addressing fit with existing schemes of identifiers and universal names?
- The short hort answeris to use Stable names (ie. DOIs) that map to content-addresses (content-hashes of the current values).
- Of course, this quickly invokes the need for an entire layer of metadata mapping between stable names and the many versions, derivatives, and sub-parts of a named entity.
- For an example of the sprawling metadata space this invokes, see the [Portland Common Data Model (PCDM)](https://github.com/duraspace/pcdm/wiki).


### Implementations

- ipfs-companion
- dweb.link / ipfs.io
- git-remote-ipld
- go-ipfs and js-ipfs


### DWeb Maturity Model

To describe the various degrees of usage of DWeb Addressing, we propose a maturity model
that breaks down the principal elements of a DWeb approach into three steps
(in spirit of the [Richardson Maturity Model](https://www.martinfowler.com/articles/richardsonMaturityModel.html)).

- Level 0: Publish Hashes for the data you hold. If you are an authoritative source for those data, sign the hashes using public key cryptography so that anyone can confirm the authenticity of the data. (examples: gx, ???, docker images?)
- Level 1: Provide a web-based API that allows people to retrieve content by its hash (github, gitlab, bitbucket, etc)
- Level 2: The data are available over P2P protocols, meaning peers can use P2P protocols to retrieve content by its hash.
- Level 3: When you reference data, reference it by Hash.
- taken from https://github.com/datatogether/datatogether/pull/7




### Future work

- security model
- ipfs:// and ipns:// protocol handlers in browsers
- dweb: protocol handler in browsers
- figuring out how multiaddrs fit into the dweb namespace
- improvements to the fuse client
- improvements to the gateway
- dapps :)
