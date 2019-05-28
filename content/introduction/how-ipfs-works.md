---
title: How IPFS Works
weight: 2
---

## What IPFS has done is make it so you don't have to worry about location

Content-addressing flips the bottom two layers of the [traditional cloud/web application stack](https://en.wikipedia.org/wiki/Internet_protocol_suite), building the entire network on linked data.

IPFS is a peer-to-peer (p2p) network that links content-addressed data to other content-addressed data. Content is accessible through peers that might relay information or store it (or do both!), and those peers can be located anywhere in the world. IPFS knows how to find what you ask for by its content address, rather than where it is.

<img alt="IPFS Stack" src="../assets/ipfs_stack.png" width="200px" />

## There are three important things to understand about IPFS

Let's first dive in to _content addressing_. This "middle" part of the IPFS stack is what connects the ecosystem together; everything is built on being able to find content via linked, unique identifiers.

### 1 \\ Content addressing

<img alt="IPFS Stack - Data Structures" src="../assets/ipfs_stack-data.png" width="200px" />

IPFS uses _content addressing_ to identify content by what's in it, rather than by where it's located. Looking for an item by content is actually something you do all the time. For example, when you look for a book in the library, you ask for it by the title; that's content addressing because you're asking for **what** it is. If you were using location addressing to find that book, you'd ask for it by **where** it is: "I want the book that's on the second floor, first stack, third shelf from the bottom, four books from the left." If someone moved that book, you'd be out of luck!

It's the same on the internet and on your computer. Right now, content is found by location, such as…

- `https://en.wikipedia.org/wiki/Aardvark`
- `/Users/Alice/Documents/term_paper.doc`
- `C:\Users\Joe\My Documents\project_sprint_presentation.ppt`

By contast, every piece of content that uses the IPFS protocol has a [*content identifier*]({{<relref "guides/concepts/cid.md">}}) that is its *hash*. The hash is unique to the content that it came from, even though it’s short (well, short compared to all the bits and bytes that make up the original content). _If hashes are new to you, check out [the concept guide on hashes]({{<relref "guides/concepts/hashes.md">}}) for a good introduction._

Content addressing through hashes has become a widely-used means of connecting data in distributed systems, from the blockchains that run your favorite cryptocurrencies, to the commits that back your code, to the web’s content at large. However, the underlying data structures in these systems are not necessarily interoperable.

This is where the [IPLD project](https://ipld.io/) comes in. **Hashes identify content, and IPLD links that content together** using any number of arrangements. It's a bit like your file system at home. You might organize all your bills by year; another person might organize them by type. These are both valid ways of organizing content, but you have to know which one you're using, otherwise you can't find anything or add anything to your folders.

IPLD is "software" that provides both rules for how to organize content-addressed data, and translations across different organization methods. Since different distributed systems structure their data in different ways, IPLD provides a platform for combining pluggable modules (parsers for each possible type of IPLD node) to resolve a path, selector, or query across many linked nodes (of varying formats, even!). IPLD really refers to any content addressable data with links to other content addressable data.

In the case of a peer to peer network using the IPFS protocol, your computer uses "IPFS-flavored IPLD" to get from raw content to an IPFS address. IPFS has its own preferences and conventions about how data should be broken up into a DAG (more on DAGs below!); IPLD links content on the IPFS network together using those conventions.

**Everything else in the IPFS ecosystem builds on top of this core concept; linked, addressable content is the fundamental connecting element that makes the rest work.**

### 2 \\ DAGs

<img alt="IPFS Stack - Applications" src="../assets/ipfs_stack-apps.png" width="200px" />

IPFS and many other distributed systems take advantage of a concept called [directed acyclic graphs](https://en.wikipedia.org/wiki/Directed_acyclic_graph), or DAGs. DAG structures are what allow distributed nodes to connect to each other in computationally reasonable ways, and are how you can build trees of content-addressed nodes.

As mentioned above, IPFS has its own preferences and conventions about how data should be broken up into DAGs that optimize for its specific use cases. You can do this chunking and structuring in lots of different ways. For example, Git is a DAG that has many versions of your repo inside of it. Its DAG tree doesn't behave in the same way the IPFS DAG does.

IPFS first separates your content into _blocks_. If you had a huge file with a single CID, you'd have to transfer the whole CID every time someone requested it. But Instead, you can break it into blocks, and transfer it block by block instead of one massive chunk at a time. Each block might come from a different source, even! This is a much more efficient way to transmit data. (If you've used BitTorrent, you may have noticed that when you download a file, it fetches it from a bunch of random people; this is the same idea.)

Another great feature of the DAG and breaking content into blocks is that if you have two similar files, they can share the DAG; ie, different trees can reference the same data. For example, if you copyedit a document and change a few commas here and there, IPFS knows to only create new blocks for those small changes. Your old version and your new version can refer to the same blocks for everything else. This can make transferring versions of large datasets (such as genomics research or weather data) much more efficient because you only need to transfer the parts that are new or have changed instead of creating entirely new files each time.

DAGs are a bit of a ["turtles all the way down"](https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/Turtles_all_the_way_down.html) scenario; that is, **everything** has a CID! You've got a file that has a CID. What if there are several files in a folder? That folder has a CID, and that CID contains the CIDs of the files underneath. In turn, those files are made up of blocks, and each of those blocks has a CID. You can see how a file system on your computer could just be a DAG. You can also, hopefully, how DAG trees start to form.

Another important aspect of DAGs to note: if you change a small part of a DAG, the whole root will become different. Take a look at [this helpful illustration using bananas](https://media.consensys.net/ever-wonder-how-merkle-trees-work-c2f8b7100ed3) from our friends at Consensys.

### 3 \\ The DHT

<img alt="IPFS Stack - Routing and Exchange" src="../assets/ipfs_stack-exchange_routing.png" width="200px" />

So, to recap, IPFS lets you to give CIDs to content, and link that content together by generating DAGs using IPLD. Now let's move on to the last piece: how you find and move that content around!

In order to find which peer has certain content (_discovery_), you use a [_distributed hash table_](https://en.wikipedia.org/wiki/Distributed_hash_table), or DHT. **IPFS is essentially a database.** Just like key-value pairs, if you have a peer, it will let you find content, and if you have content, it will let you find you the peer where the content is stored.

The <a hrefm src="https://libp2p.io/">libp2p project</a> is the part of the IPFS ecosystem that provides the DHT and handles peers connecting and talking to each other. It can be used as a tool for other distributed systems as well; just as there is "IPFS-flavored IPLD," there's also "IPFS-flavored libp2p."

Once you know where your content is (ie, which peer or peers are storing the various blocks that make up the content you're after), you use the DHT **again** to find the current location of those peers (_routing_). So, in order to get to content, you use libp2p to query the DHT twice.

You've discovered your content, and you've found the current location(s) of that content — now you need to connect to that content (_exchange_). libp2p again to the rescue! _[Maybe something here about bootstrapping, Bitswap, or Graphsync.]_

What makes the IPFS protocol especially useful for peer to peer connections is _multiplexing_. Traditionally, you open a different connection to each protocol you talk to. Using IPFS, you open just one connection, and you multiplex everything on that. For everything your peers have to talk to each other about, you send a little bit of each thing, and the other end knows how to sort those chunks where they belong.

This is useful because establishing a connection in p2p systems is sometimes difficult depending on where they are. Once you have that connectivity, you can do whatever you need on it. And you only need one socket.


## And everything is modular

As you may have noticed from this discussion, the IPFS ecosystem is made up of many modular libraries that support specific parts of any distributed system. You can certainly use any part of the stack independently, or combine them in novel ways!

For example, all of the exchange and routing parts of the stack will let you open a connection, and exchange that data with other peers. And _[insert another example here.]_


## Summary

The IPFS ecosystem lets you to give CIDs to content, and link that content together by generating DAGs using IPLD. You can discover content using a DHT that's provided by libp2p, and open a connection to that content and move it around via libp2p as well. All of this is held together by the "middle" of stack, which is linked, unique identifiers; that's the essential part that the IPFS is built on.

Next, we'll look at how really, instead of a network "stack", IPFS is an interconnected network of equal peers, each with the same abilities (no server-client relationships), and what that means for system architectures. We'll also touch on another useful project in the ecosystem — IPFS Cluster — that can help make sure your content is always available, even on a network like IPFS that supports peers dropping in and out at will.
