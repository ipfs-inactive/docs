---
title: "Distributed Hash Table (DHT)"
menu:
    guides:
        parent: concepts
---

# DHTs

## What is a DHT?

[Distributed Hash Tables](https://en.wikipedia.org/wiki/Distributed_hash_table) (DHT) are a distributed key-value store where keys are [cryptographic hashes](https://docs.ipfs.io/guides/concepts/hashes/). 

DHTs are distributed. Each "peer" (or "node") is responsible for a subset of the DHT. 
A receiving peer either answers the request, or forward it until another peer can answer it.

DHT's decentralization provides advantages compared to a classic Key-Value store:
- *scalability* as a request for a hash of length *n* takes at most *log2(n)* steps to resolve.
- *fault tolerance* via redundancy, so that lookups are possible even if peers unexpectedly leave or join the DHT. Additionally, requests can be addressed to any peer if one is slow or unavailable.
- *load balancing* as requests are made to different nodes and no unique peers process all the requests. 

## How do DHTs work?

### Peer IDs
Each peer have a peerID which is a hash with the same length *n* as the DHT keys.

### Buckets
A subset of the DHT maintained by a peer is called a 'bucket'. 
A bucket maps to hashes with the same prefix as the PeerID up to *m* bits. There are 2^m buckets. Each bucket maps for 2^(n-m) hashes.

- For example, if m = 2^16 and with an hexadecimal encoding (4 bits per displayed character), the peer with PeerID "ABCDEF12345" maintains mapping for hashes starting with "ABCD". 
Some hashes falling into this bucket would be *ABCD*38E56, *ABCD*09CBA or *ABCD*17ABB ... 

The size of the buckets are related to the size of the prefix. The longer the prefix, the less hashes each peer has to manage, the more peers are needed.
Several peers can be in charge of the same bucket if they have the same prefix.

In most DHTs, including IPFS's Kademlia implementation, the size of the buckets (and the size of the prefix), are dynamic. 
Buckets size growths and prefix size shortens when many nodes leaves the DHT, and vice versa. **(/!\ or does it depends on the number of records and not the number of nodes? Is it at bucket level or DHT level?)**

### Peer lists

Peers also keep connection to other peers to forward requests if the requested hash is not in their own bucket.

If hashes are of length n, a peer will keep n-1 lists of peers: 
- the first list contains peers which ID have a different 1st bit.
- the second list contains peer which have their first bits identical to its own, but a different second bit
- ...
- the m-th list contains peer which have their first m-1 bits identical, but a different m-th bit
- ...

The higher m, the harder it is to find peers which have the same ID up to m bits. The lists of "closest" peers typically remains empty.
"Close" here is defined as the XOR distance, so the longer the prefix they share, the closer they are.
Lists also have a maximum of entries k, otherwise the first lists would contain half the network, then a fourth, etc.

### Using the DHT

When a peer receives a lookup request, it will either answer with a value if it falls into its own bucket, or forward it to the closest peer it knows from the requested hash. The process goes on until a peer is able to answer it. **(Does is it answer directly to requesting peer? Or does the answer takes the same path as the request?)**
A request for a hash of length n will take at maximum log2(n) steps. 

# The DHT of IPFS

In IPFS Kademlia's DHT, keys are not hashes but [multihashes](https://multiformats.io/multihash/): a generalization of the cryptographic hashes containing also information about which hashing function was used, and the length of the hash in bits.
[PeerIDs](https://docs.libp2p.io/concepts/peer-id/) are those of [libp2p]([PeerIDs](https://docs.libp2p.io/concepts/peer-id/), the networking library used by IPFS.

We use a DHT to lookup two types of objects (both represented by a multihash):
- [Content IDs](https://docs.ipfs.io/guides/concepts/cid/) of the data added to IPFS. A lookup of this value will give the peerIDs of the peers having this content.
- PeerIDs. A lookup will give all the [multiaddresses](https://multiformats.io/multiaddr/) to reach the peer(s) actually having the content.
Consequently, IPFS's DHT is used for content routing (1st lookup) and for peer routing (2nd lookup). 

**(what is m and k for IPFS? Does it depends on specs? implementation? )**
