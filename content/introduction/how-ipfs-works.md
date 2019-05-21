---
title: How IPFS Works
weight: 4
---

## What IPFS has done is make it so you don't have to worry about location

Content-addressing flips the bottom two layers of the [traditional cloud/web application stack](https://en.wikipedia.org/wiki/Internet_protocol_suite), building the entire network on linked data.

IPFS is a peer-to-peer (p2p) network — you could also call it an identifier-to-identifier network. Content is accessible through peers. Since peers are location-agnostic, your content is location agnostic.

<img alt="IPFS Stack" src="../assets/ipfs_stack.png" width="200px" />

## There are three important things to understand about IPFS

### 1 \\ The DHT

<img alt="IPFS Stack - Routing and Exchange" src="../assets/ipfs_stack-exchange_routing.png" width="200px" />

In order to find which peer has certain content (_discovery_), you use the distributed hash table, or DHT. Once you know where your content is, you use the DHT again to find the current location of that peer (_routing_). So, in order to get to content, you query the DHT twice.

IPFS is essentially a database. Just like key-value pairs in a database, if you have a peer, it will let you find content. If you have content, it will let you find you the peer where the content is stored.

<div class="alert alert-info">
    The <a hrefm src="https://libp2p.io/">libp2p</a> project is the part of the IPFS ecosystem that provides the DHT. It gives you the peerID, the peer itself, and abstracts all the network layer stuff so you can use anything with those peers. Then, on top of those peers, it builds services like the DHT.
</div>

So, now you know how to discover content, and you know how to reach peers that have that content. The _exchange_ layer is how you connect to that content. This depends on which protocols the peers understand. http? Bitswap? What protocol are you using so that you can connect to that peer and exchange content with that peer?

What makes the IPFS protocol especially useful for peer to peer connections is _multiplexing_. Traditionally, you open a different connection to each protocol you talk to. Using IPFS, you open just one connection, and you multiplex everything on that. For everything your peers have to talk to each other about, you send a little bit of each thing, and the other end knows how to sort those chunks where they belong.

This is useful because establishing a connection in p2p systems might be hard depending where they are. Once you have that connectivity, you can do whatever you need on it. And you only need one socket.



### 2 \\ Content addressing


### 3 \\ DAGs
