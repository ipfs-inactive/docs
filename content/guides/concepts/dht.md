---
title: "Distributed Hash Table (DHT)"
menu:
    guides:
        parent: concepts
---

## DHT

# What is a DHT?

Distributed Hash Tables (DHT) are a distributed key-value store where keys are cryptographic hashes. 

DHTs are distributed. Each "peer" (or "node") is responsible for a subset of the DHT. 
These subsets are called 'buckets', and map to some prefix of the hash. 
More precisely, a peer maintains the DHT for hashes sharing their prefix with its own PeerID (which is also a hash) up to a length of m bits. If n is the length of the hashes in bits, each bucket maps for 2^(n-m) hashes.

For example, if m = 2^4 and an hexadecimal encoding, the peer with PeerID "ABCDEF12345" can maintain mapping for hashes starting with "ABCD". 
Some hashes falling into this bucket would be *ABCD*38E56, *ABCD*09CBA or *ABCD*17ABB ... 

The size of the buckets are related to the size of the prefix. The longer the prefix, the less hashes each peer has to manage, the more peers are needed.
Several peers can be in charge of the same bucket if they have the same prefix.

In most DHTs, including IPFS's Kademlia implementation, the size of the buckets (and the size of the prefix), are dynamic. 
Buckets size growths and prefix size shortens when many nodes leaves the DHT, and vice versa. (/!\ or does it depends on the number of records and not the number of nodes? Is it at bucket level or DHT level?)

Peers also keep connection to other peers to forward requests if the requested hash is not in their own bucket.

If hashes are of lentgh n, a peer will keep n-1 lists of peers: 
- the first list contains peers which ID have a different 1st bit.
- the second list contains peer which have their first bits indentical to its own, but a different second bit
- ...
- the m-th list contains peer which have their first m-1 bits identical, but a differnt m-th bit
- ...

The higher m, the harder it is to find peers which have the same ID up to m bits. The lists of "closest" peers typically remains empty.
"Close" here is defined as the XOR distance, so the longer the prefix they share, the closer they are.
Lists also have a maximum of entries k, otherwise the first lists would contain half the network, then a fourth, etc.

When a peer receives a lookup request, it will either answer with a value if it falls into its own bucket, or forward it to the closest peer it knows from the requested hash.  
the process goes on until a peer is able to answer it.
A request for a hash of length n will take at maximum log2(n) steps. 

DHT's decentralisation provides advantages compared to a classic Key-Value store:
- *scalability* as each node only needs to maintain mapping for a fraction of the Key-Value pairs.
- *fault tolerance* via redunduncy, so that lookup are possible even if peers unexpectedly leave or join the DHT.
- *load balancing* as requests are made to different nodes and no unique peers process all the requests. Additionaly, any request can be addressed to any peer.

## The DHT of IPFS

In IPFS Kademlia's DHT, keys are not hashes but multihashes: a generalisation of the cryptographic hashes containing also information about which hashing function was used, and the length of the hash.

We use a DHT to lookup two types of objects (both represented by a multihash):
- Content IDs of the data added to IPFS. A lookup of this value will give the peerIDs of the peers having this content.
- PeerIDs of IPFS (libp2p?) nodes. A lookup will give all the multiaddresses to reach the peer(s) actually having the content.
Consequently, IPFS's DHT is use for content routing (1st lookup) and for peer routing (2nd lookup). 

(what is m and k for IPFS? Does it depends on specs? implementation? )
