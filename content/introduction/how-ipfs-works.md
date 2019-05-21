---
title: How IPFS Works
weight: 4
---

## What IPFS has done is make it so you don't have to worry about location

Content-addressing flips the bottom two layers of the [traditional cloud/web application stack](https://en.wikipedia.org/wiki/Internet_protocol_suite), building the entire network on linked data.

IPFS is a peer-to-peer (p2p) network — you could also call it an identifier-to-identifier network (that links content-identified data to other content-identified data). Content is accessible through peers. Since peers are location-agnostic, your content is location agnostic.

<img alt="IPFS Stack" src="../assets/ipfs_stack.png" width="200px" />

## There are three important things to understand about IPFS

What IPFS has done is separate content and location, as we mentioned above. In order to use IPFS, you have to put content into at least one node. And you need to connect that node to at least one other. Let's first dive in to the content identifier bit. This "middle" part of the IPFS stack is what connects the ecosystem together; everything is built on being able to find content via unique identifiers.

### 1 \\ Content addressing

<img alt="IPFS Stack - Data Structures" src="../assets/ipfs_stack-data.png" width="200px" />

IPFS uses _content addressing_ to identity content by what's in it, rather than by where it's located. Looking for an item by content is actually something you do all the time. For example, when you look for a book in the library, you ask for it by the title; that's content addressing because you're asking for *what* it is. If you were using location addressing to find that book, you'd ask for it by *where* it is; "I want the book that's on the second floor, first stack, third shelf from the bottom, four books from the left." If someone moved that book, you'd be out of luck!

It's the same on the internet and on your computer. Right now, content is found by location, such as…

- `https://en.wikipedia.org/wiki/Aardvark`
- `/Users/Alice/Documents/term_paper.doc`
- `C:\Users\Joe\My Documents\project_sprint_presentation.ppt`

Every piece of content using the IPFS protocol has a [*content identifier*]({{<relref "guides/concepts/cid.md">}}) that is its *hash*. The hash is unique to the content that it came from, even though it’s short (well, short compared to all the bits and bytes that make up the original content). If hashes are new to you, check out [the concept guide on hashes]({{<relref "guides/concepts/hashes.md">}}) for a good introduction.

In truth, though, content addressing through hashes has become a widely-used means of connecting data in distributed systems, from the blockchains that run your favorite cryptocurrencies, to the commits that back your code, to the web’s content at large. However, in all these examples, their underlying data structures are not necessarily interoperable; that is, they probably can't talk to each other.

This is where the [IPLD project](https://ipld.io/) comes in. **Hashes identify content, and IPLD links that content together** using any number of arrangements. It's a bit like your file system at home. You might organize all your bills by year; another person might organize them by type. These are both valid ways of organizing content, but you have to know which one you're using, otherwise you can't find anything or add anything to your folders.

You can think of IPLD as the "software" that provides both rules for how to organize content-addressed data, and translations across different organization methods. Different distributed systems (such as the blockchains that run cryptocurrencies, the commits that back your code, the web’s content at large) all structure their data differently. IPLD is just a system for combining pluggable modules (parsers for each possible type of IPLD node) to resolve a path, selector, or query across many linked nodes (of varying formats, even!). IPLD really refers to any content addressable data with links to other content addressable data.

In the case of a peer to peer network using the IPFS protocol, your computer uses "IPFS-flavored IPLD" to get from content to an IPFS address. IPFS has its own preferences and conventions about how data should be broken up into a DAG; IPLD links content on the IPFS network together using those conventions.

Everything else in the IPFS ecosystem builds on top of this core concept: content is the link that connects all the other parts.

### 2 \\ DAGs

<img alt="IPFS Stack - Applications" src="../assets/ipfs_stack-apps.png" width="200px" />

The next step after content addressing is defining DAGs. How you can build trees of content-addressed nodes.

If you change a small part, the whole root will become different. Different trees can reference the same data.

(copy Consensys description)

So, you've got a file that has a CID. What if there are several files in a folder? That folder has a CID, and that CID contains the CIDs of the files underneath. You can see how a file system on your computer could just be a DAG. Also Git.

What IPFS does is enable you to build that — generate DAGs for your content, to convert your files and folders to a DAG, and transmit that DAG to other peers. Because it's content-addressed, it doesn't matter who gives you that DAG, you can still find the content via the exchange and routing talked about above.

For example, when you run IPFS, you have an IPFS `add` command. It will give you a CID that uniquely identifies the content that you `add`ed. Someone else will be able to discover and request that content from your peer using that CID.

Actually, if you really want to know how IPFS does this, IPFS separates your content into _blocks_. If you have a huge file with a single CID, you'd have to transfer the whole CID. But if you break it into blocks, then you can transfer block by block.

And, you can do this chunking is lots of different ways. For example, Git. It's a DAG that has many versions of your repo inside of it. IPFS itself isn't pushing and replicating your content anywhere; people have to discover it and choose to host it.

If you've used BitTorrent, you may have noticed that when you want to download a file, it fetches it from a bunch of random people. It uses a DHT to do that.

Another great feature of the DAG and breaking content into blocks is that if you have two similar files, they can share the DAG. If you copyedit a document and change a few commas here and there, IPFS knows to only create new blocks for those small changes. Otherwise, your old version and your new version can refer to the same blocks. This can make transferring versions of large datasets (such as genomics research or weather data) much more efficient because you only need to transfer the parts that are new or have changed.

### 3 \\ The DHT

<img alt="IPFS Stack - Routing and Exchange" src="../assets/ipfs_stack-exchange_routing.png" width="200px" />

In order to find which peer has certain content (_discovery_), you use a [_distributed hash table_](https://en.wikipedia.org/wiki/Distributed_hash_table), or DHT. Once you know where your content is, you use the DHT again to find the current location of that peer (_routing_). So, in order to get to content, you query the DHT twice.

IPFS is essentially a database. Just like key-value pairs, if you have a peer, it will let you find content. If you have content, it will let you find you the peer where the content is stored.

<div class="alert alert-info">
    The <a hrefm src="https://libp2p.io/">libp2p</a> project is the part of the IPFS ecosystem that provides the DHT. It gives you the peerID, connects you to the peer itself, and abstracts all the network layer stuff so you can use anything with those peers. Then, on top of those peers, it builds services like the DHT. In short, libp2p provides all the stuff that handles peers being able to connect to each other and talk to each other.
</div>

So, now you know how to discover content, and you know how to reach peers that have that content. The _exchange_ layer is how you connect to that content. This depends on which protocols the peers understand. http? Bitswap? What protocol are you using so that you can connect to that peer and exchange content with that peer?

What makes the IPFS protocol especially useful for peer to peer connections is _multiplexing_. Traditionally, you open a different connection to each protocol you talk to. Using IPFS, you open just one connection, and you multiplex everything on that. For everything your peers have to talk to each other about, you send a little bit of each thing, and the other end knows how to sort those chunks where they belong.

This is useful because establishing a connection in p2p systems might be hard depending where they are. Once you have that connectivity, you can do whatever you need on it. And you only need one socket.


## And everything is modular.

You can still use the other parts of the stack independently.

It's true that IPFS does content addressing, but if you leave that out, all the routing and exchange stuff is content-agnostic.

Imagine that your data is content-addressed. We can use the DHT to find which peers have this data.

All of the exchange and routing parts of the stack will let me open a connection, and exchange that data with other peers.
