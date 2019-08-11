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
A receiving peer either answers the request, or the request is passed to another peer until a peer can answer it.
Depending on implementations, a request not answered by the first contacted node can be :
- forwarded from peer to peer and the last peer contact the requesting peer
- forwarded from peer to peer and the answered is forwarded following the same path
- answered with contacting information of a node having better chances to be able to answer (IPFS uses this strategy)

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

When a peer receives a lookup request, it will either answer with a value if it falls into its own bucket, or answer with the contacting information (IP + port, peerID, etc) of a closer peer. The requesting peer can then send its request to this closer peer. The process goes on until a peer is able to answer it. 
A request for a hash of length n will take at maximum log2(n) steps, or even log2m(n). 

# The DHT of IPFS

In IPFS Kademlia's DHT, keys are SHA256 hashes.
[PeerIDs](https://docs.libp2p.io/concepts/peer-id/) are those of [libp2p](https://libp2p.io/), the networking library used by IPFS.

We use a DHT to lookup two types of objects (both represented by a SHA256):
- [Content IDs](https://docs.ipfs.io/guides/concepts/cid/) of the data added to IPFS. A lookup of this value will give the peerIDs of the peers having this immutable content
- [IPNS records](https://docs.ipfs.io/guides/concepts/ipns/). A lookup will give the last Content ID associated with this IPNS address, enabling routing mutable content

Consequently, IPFS's DHT is one of the way of mutable and immutable [Content Routing](https://docs.libp2p.io/concepts/content-routing/). It's currently the only one [implemented](https://libp2p.io/implementations/#peer-routing). 

Per specification, the default bucket size k is 20 : each of the 255 lists of peers contain at most 20 peers. 

## Usage

### Adding an entry

Adding a blob of data to IPFS is just advertizing that you have it. Since DHT is the only content routing implemented, you can just use
` ipfs add myData`
IPFS will automatically chunk your data and add a mapping on the DHT between the Content ID and your PeerID. Note that there can be other Peer IDs already mapped to that value, so you will be added to the list. Also note that if the provided data is bigger than 124kb, it will be chunked in "blocks" and both blocks and overall data will be mapped. 



**(what is m and k for IPFS? Does it depends on specs? implementation? )**
