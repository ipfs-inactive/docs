+++
title = "MultiStream"
description = "Self describing streams"
weight = 5
+++

> Make data and streams self-described by prefixing them with human readable codecs.

## Table of Contents

- [Motivation](#motivation)
  - [How does it work? - Protocol Description](#how-does-it-work---protocol-description)
  - [The protocol path](#the-protocol-path)
- [Implementations](#implementations)
  - [Implementation details]()
- [FAQ](#faq)

## Motivation

Multicodecs are self-describing protocol/encoding streams. (Note that a file is a stream). It's designed to address the perennial problem:

> I have a bitstring, what codec is the data coded with!?

Instead of arguing about which data serialization library is the best, let's just pick the simplest one now, and build _upgradability_ into the system. Choices are never _forever_. Eventually all systems are changed. So, embrace this fact of reality, and build change into your system now.

Multicodec frees you from the tyranny of past mistakes. Instead of trying to figure it all out beforehand, or continue using something that we can all agree no longer fits, why not allow the system to _evolve_ and _grow_ with the use cases of today, not yesterday.

To decode an incoming stream of data, a program must either (a) know the format of the data a priori, or (b) learn the format from the data itself. (a) precludes running protocols that may provide one of many kinds of formats without prior agreement on which. multistream makes (b) neat using self-description.

Moreover, this self-description allows straightforward layering of protocols without having to implement support in the parent (or encapsulating) one.

## How does it work? - Protocol Description

`multistream` is a _self-describing multiformat_, it wraps other formats with a tiny bit of self-description:

```sh
<varint-len>/<codec>\n<encoded-data>
```

For example, let's encode a json doc:

```JavaScript
// encode some json
const buf = new Buffer(JSON.stringify({ hello: 'world' }))

const prefixedBuf = multistream.addPrefix('json', str) // prepends multicodec ('json')
console.log(prefixedBuf)
// <Buffer 06 2f 6a 73 6f 6e 2f 7b 22 68 65 6c 6c 6f 22 3a 22 77 6f 72 6c 64 22 7d>

const.log(prefixedBuf.toString('hex'))
// 062f6a736f6e2f7b2268656c6c6f223a22776f726c64227d

// let's get the Codec and then get the data back

const codec = multicodec.getCodec(prefixedBuf)
console.log(codec)
// json

console.log(multistream.rmPrefix(prefixedBuf).toString())
// "{ \"hello\": \"world\" }
```

So, `buf` is:

```
hex:   062f6a736f6e2f7b2268656c6c6f223a22776f726c64227d
ascii: /json\n"{\"hello\":\"world\"}"
```

Note that on the ascii version, the varint at the beginning is not being represented, you should account that.

## The protocol path

`multistream` allows us to specify different protocols in a universal namespace, that way being able to recognize, multiplex, and embed them easily. We use the notion of a `path` instead of an `id` because it is meant to be a Unix-friendly URI.

A good path name should be decipherable -- meaning that if some machine or developer -- who has no idea about your protocol -- encounters the path string, they should be able to look it up and resolve how to use it.

An example of a good path name is:

```
/bittorrent.org/1.0
```

An example of a _great_ path name is:

```
/ipfs/Qmaa4Rw81a3a1VEx4LxB7HADUAXvZFhCoRdBzsMZyZmqHD/ipfs.protocol
/http/w3id.org/ipfs/1.1.0
```

These path names happen to be resolvable -- not just in a "multistream muxer(e.g [multistream-select](https://github.com/multiformats/multistream-select))" but -- in the internet as a whole (provided the program (or OS) knows how to use the `/ipfs` and `/http` protocols).

## Implementations

- [go-multistream-select](https://github.com/multiformats/go-multistream)
- [js-multistream-select](https://github.com/multiformats/js-multistream-select)

## FAQ

> **Q. Why?**

Today, people speak many languages, and use common ones to interface. But every "common language" has evolved over time, or even fundamentally switched. Why should we expect programs to be any different?

And the reality is they're not. Programs use a variety of encodings. Today we like JSON. Yesterday, XML was all the rage. XDR solved everything, but it's kinda retro. Protobuf is still too cool for school. capnp ("cap and proto") is
for cerealization hipsters.

The one problem is figuring out what we're speaking. Humans are pretty smart, we pick up all sorts of languages over time. And we can always resort to pointing and grunting (the ascii of humanity).

Programs have a harder time. You can't keep piping json into a protobuf decoder and hope they align. So we have to help them out a bit. That's what multicodec is for.

> **Q. Why "codec" and not "encoder" and "decoder"?**

Because they're the same thing. Which one of these is the encoder and which the decoder?

    5555 ----[ THING ]---> 8888
    5555 <---[ THING ]---- 8888

> **Q. Full paths are too big for my use case, is there something smaller?**

Yes, check out [multicodec-packed](./multicodec-packed.md). It uses a varint and a table to achieve the same thing.
