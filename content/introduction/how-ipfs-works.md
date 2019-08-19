---
title: How IPFS Works
weight: 2
---

IPFS is a peer-to-peer (p2p) network that links content-addressed data to other content-addressed data. Content is accessible through peers that might relay information or store it (or do both!), and those peers can be located anywhere in the world. IPFS knows how to find what you ask for by its content address, rather than where it is.

## There are three important things to understand about IPFS

Let’s first dive in to _content addressing_ and how that content is _linked together_. This “middle” part of the IPFS stack is what connects the ecosystem together; everything is built on being able to find content via linked, unique identifiers.

### 1 \\ Content addressing and linked data

IPFS uses _content addressing_ to identify content by what’s in it, rather than by where it’s located. Looking for an item by content is something you already do all the time. For example, when you look for a book in the library, you often ask for it by the title; that’s content addressing because you’re asking for **what** it is. If you were using location addressing to find that book, you’d ask for it by **where** it is: “I want the book that’s on the second floor, first stack, third shelf from the bottom, four books from the left.” If someone moved that book, you’d be out of luck!

It’s the same on the internet and on your computer. Right now, content is found by location, such as…

- `https://en.wikipedia.org/wiki/Aardvark`
- `/Users/Alice/Documents/term_paper.doc`
- `C:\Users\Joe\My Documents\project_sprint_presentation.ppt`

By contast, every piece of content that uses the IPFS protocol has a [*content identifier*]({{<relref "guides/concepts/cid.md">}}), or CID, that is its *hash*. The hash is unique to the content that it came from, even though it may look short compared to the original content. _If hashes are new to you, check out [the concept guide on hashes]({{<relref "guides/concepts/hashes.md">}}) for a good introduction._

Content addressing through hashes has become a widely-used means of connecting data in distributed systems, from the commits that back your code to the blockchains that run cryptocurrencies. However, the underlying data structures in these systems are not necessarily interoperable.

This is where the [IPLD project](https://ipld.io/) comes in. **Hashes identify content, and IPLD links that content together**. Since different distributed systems structure their data in different ways, IPLD provides libraries for combining pluggable modules (parsers for each possible type of IPLD node) to resolve a path, selector, or query across many linked nodes (allowing you explore data regardless of the underlying protocol). IPLD really refers to any content addressable data with links to other content addressable data: “Oh you use Git-style, no worries, I can follow those links. Oh you use Ethereum, I got you, I can follow those links too!”

The IPFS protocol uses “IPFS-flavored IPLD” to get from raw content to an IPFS address. IPFS has its own preferences and conventions about how data should be broken up into a DAG (more on DAGs below!); IPLD links content on the IPFS network together using those conventions.

**Everything else in the IPFS ecosystem builds on top of this core concept: linked, addressable content is the fundamental connecting element that makes the rest work.**

### 2 \\ DAGs

IPFS and many other distributed systems take advantage of a data structure called [directed acyclic graphs](https://en.wikipedia.org/wiki/Directed_acyclic_graph), or DAGs. Specifically, they use _Merkle-DAGs_, which are DAGs where each node has an identifier that is a hash of the node’s contents. Sound familiar? Yup, this refers back to the _CID_ concept that we covered in the previous section. Another way to look the whole CID-linked-data thing: identifying a data object (like a Merkle-DAG node) by the value of its hash is _content addressing_. _(Check out [the concept guide on Merkle-DAGs]({{<relref "guides/concepts/merkle-DAG.md">}}) for a more in-depth treatment of this topic.)_

IPFS uses a Merkle-DAG that is optimized for representing directories and files, but you can structure a Merkle-DAG in lots of different ways. For example, Git uses a Merkle-DAG that has many versions of your repo inside of it.

To build a Markle-DAG representation of your content, IPFS first separates it into _blocks_. If you had a huge file with a single CID, you’d have to transfer the whole file in a single chunk every time someone requested it. But instead, you can break it into blocks, and transfer it block by block. Splitting it into blocks also means that different parts of the file can come from different sources. This is a much more efficient way to transmit data. (If you've used BitTorrent, you may have noticed that when you download a file, it can fetch it from multiple peers at once; this is the same idea.)

Merkle-DAGs are a bit of a [“turtles all the way down”](https://ipfs.io/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/Turtles_all_the_way_down.html) scenario; that is, **everything** has a CID! You’ve got a file that has a CID. What if there are several files in a folder? That folder has a CID, and that CID contains the CIDs of the files underneath. In turn, those files are made up of blocks, and each of those blocks has a CID. You can see how a file system on your computer could just be a DAG. You can also, hopefully, how Merkle-DAG graphs start to form. For a fun visual exploration of this, take a look at our [IPLD Explorer](https://explore.ipld.io/#/explore/QmSnuWmxptJZdLJpKRarxBMS2Ju2oANVrgbr2xWbie9b2D)!

Another great feature of a Merkle-DAG and breaking content into blocks is that if you have two similar files, they can share parts of the Merkle-DAG; ie, parts of different Merkle-DAGs can reference the same data. For example, if you update a website, then only the files that changed will get new content adresses. Your old version and your new version can refer to the same blocks for everything else. This can make transferring versions of large datasets (such as genomics research or weather data) much more efficient because you only need to transfer the parts that are new or have changed instead of creating entirely new files each time.


### 3 \\ The DHT

So, to recap, IPFS lets you to give CIDs to content, and link that content together in a Merkle-DAG using IPLD. Now let’s move on to the last piece: how you find and move content.

To find which peers are hosting the content you’re after (_discovery_), IPFS uses a [_distributed hash table_](https://en.wikipedia.org/wiki/Distributed_hash_table), or DHT. A hash table is a database of keys to values. A _distributed_ hash table is one where the table is split across all the peers in a distributed network. To find content, you ask these peers.

The <a hrefm src="https://libp2p.io/">libp2p project</a> is the part of the IPFS ecosystem that provides the DHT and handles peers connecting and talking to each other. It can be used as a tool for other distributed systems as well; just as there is “IPFS-flavored IPLD,” there’s also “IPFS-flavored libp2p.”

Once you know where your content is (ie, which peer or peers are storing the various blocks that make up the content you’re after), you use the DHT **again** to find the current location of those peers (_routing_). So, in order to get to content, you use libp2p to query the DHT twice.

**TODO: —> this description of exchange might not be right, and we perhaps need something about bootstrapping, Bitswap, or Graphsync.** You’ve discovered your content, and you’ve found the current location(s) of that content — now you need to connect to that content (_exchange_). libp2p again to the rescue! _[Maybe something here about bootstrapping, Bitswap, or Graphsync.]_

What makes libp2p especially useful for peer to peer connections is _connection multiplexing_. Traditionally, every service in a system would open a different connection to remotely communicate with other services of the same kind. Using IPFS, you open just one connection, and you multiplex everything on that. For everything your peers have to talk to each other about, you send a little bit of each thing, and the other end knows how to sort those chunks where they belong.

This is useful because establishing connections is usually hard to set up and expensive to maintain. With multiplexing, once you have that connection, you can do whatever you need on it.


## And everything is modular

As you may have noticed from this discussion, the IPFS ecosystem is made up of many modular libraries that support specific parts of any distributed system. You can certainly use any part of the stack independently, or combine them in novel ways!

**TODO: —> this first example isn't quite right yet, and we could use another.** For example, all of the exchange and routing parts of the stack will let you open a connection, and exchange that data with other peers. And _[insert another example here.]_


## Summary

The IPFS ecosystem gives CIDs to content, and links that content together by generating IPLD-Merkle-DAGs. You can discover content using a DHT that's provided by libp2p, and open a connection to any provider of that content and move it around using a multiplexed connection. All of this is held together by the “middle” of stack, which is linked, unique identifiers; that's the essential part that the IPFS is built on.

Next, we’ll look at how IPFS is an interconnected network of equal peers, each with the same abilities (no client-server relationships), and what that means for system architectures. We’ll also touch on another useful project in the ecosystem — IPFS Cluster — that can help make sure your content is always available, even on a network like IPFS that supports peers dropping in and out at will.