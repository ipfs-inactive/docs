---
title: "Distributed Hash Tables (DHT)"

menu:
    guides:
        parent: concepts
beta_equivalent: concepts/dht
---

# DHTs

## What is a DHT?

[Distributed Hash Tables](https://en.wikipedia.org/wiki/Distributed_hash_table) (DHTs) are distributed key-value stores where keys are [cryptographic hashes](https://docs.ipfs.io/guides/concepts/hashes/).

DHTs are distributed. Each "peer" (or "node") is responsible for a subset of the DHT.
When a peer receives a request, it either answers it, or the request is passed to another peer until a peer that can answer it is found.
Depending on the implementation, a request not answered by the first node contacted can be:
- forwarded from peer to peer, with the last peer contacting the requesting peer
- forwarded from peer to peer, with the answer forwarded following the same path
- answered with the contact information of a node that has better chances to be able to answer. **IPFS uses this strategy.**

DHTs' decentralization provides advantages compared to a traditional key-value store, including:
- *scalability*, since a request for a hash of length *n* takes at most *log2(n)* steps to resolve.
- *fault tolerance* via redundancy, so that lookups are possible even if peers unexpectedly leave or join the DHT. Additionally, requests can be addressed to any peer if another peer is slow or unavailable.
- *load balancing*, since requests are made to different nodes and no unique peers process all the requests.

## How does the IPFS DHT work?

### Peer IDs
Each peer has a `peerID`, which is a hash with the same length *n* as the DHT keys.

### Buckets
A subset of the DHT maintained by a peer is called a 'bucket'.
A bucket maps to hashes with the same prefix as the `peerID`, up to *m* bits. There are 2^m buckets. Each bucket maps for 2^(n-m) hashes.

For example, if *m*=16 and we use hexadecimal encoding (four bits per displayed character), the peer with `peerID` 'ABCDEF12345' maintains mapping for hashes starting with 'ABCD'.
Some hashes falling into this bucket would be *ABCD*38E56, *ABCD*09CBA or *ABCD*17ABB, just as examples.

The size of a bucket is related to the size of the prefix. The longer the prefix, the fewer hashes each peer has to manage, and the more peers are needed.
Several peers can be in charge of the same bucket if they have the same prefix.

In most DHTs, including [IPFS's Kademlia implementation](https://github.com/libp2p/specs/blob/8b89dc2521b48bf6edab7c93e8129156a7f5f02c/kad-dht/README.md), the size of the buckets (and the size of the prefix), are dynamic.


### Peer lists

Peers also keep a connection to other peers in order to forward requests if the requested hash is not in their own bucket.

If hashes are of length n, a peer will keep n-1 lists of peers:
- the first list contains peers whose IDs have a different first bit.
- the second list contains peers whose IDs have first bits identical to its own, but a different second bit
- ...
- the m-th list contains peers whose IDs have their first m-1 bits identical, but a different m-th bit
- ...

The higher m is, the harder it is to find peers that have the same ID up to m bits. The lists of "closest" peers typically remains empty.
"Close" here is defined as the XOR distance, so the longer the prefix they share, the closer they are.
Lists also have a maximum of entries (k) — otherwise the first lists would contain half the network, then a fourth of the network, and so on.

### Using the DHT

When a peer receives a lookup request, it will either answer with a value if it falls into its own bucket, or answer with the contacting information (IP+port, `peerID`, etc.) of a closer peer. The requesting peer can then send its request to this closer peer. The process goes on until a peer is able to answer it.
A request for a hash of length n will take at maximum log2(n) steps, or even log2m(n).

### Keys and hashes

In IPFS's Kademlia DHT, keys are SHA256 hashes.
[PeerIDs](https://docs.libp2p.io/concepts/peer-id/) are those of [libp2p](https://libp2p.io/), the networking library used by IPFS.

We use the DHT to look up two types of objects, both represented by SHA256 hashes:
- [Content IDs](https://docs.ipfs.io/guides/concepts/cid/) of the data added to IPFS. A lookup of this value will give the `peerID`s of the peers having this immutable content.
- [IPNS records](https://docs.ipfs.io/guides/concepts/ipns/). A lookup will give the last Content ID associated with this IPNS address, enabling the routing of mutable content.

Consequently, IPFS's DHT is one of the ways to achieve mutable and immutable [content routing](https://docs.libp2p.io/concepts/content-routing/). It's currently the only one [implemented](https://libp2p.io/implementations/#peer-routing).

You can learn more in the [libp2p Kademlia DHT specification](https://github.com/libp2p/specs/blob/8b89dc2521b48bf6edab7c93e8129156a7f5f02c/kad-dht/README.md).

## Usage

### Adding an entry

Adding a blob of data to IPFS is the equivalent of advertising that you have it. Since DHT is the only content routing implemented, you can just use:
` ipfs add myData`
IPFS will automatically chunk your data and add a mapping on the DHT between the Content ID and your `peerID`. Note that there can be other `peerID`s already mapped to that value, so you will be added to the list. Also note that if the provided data is bigger than 124KB, it will be chunked into "blocks", and both those blocks and the overall data will be mapped.

You can publish an IPNS record using [`ipfs.name.publish`](https://docs.ipfs.io/guides/concepts/ipns/).
