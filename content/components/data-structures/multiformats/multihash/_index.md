+++
title = "MultiHash"
description = "Self describing hashes"
weight = 1
+++

> Self identifying hashes

Multihash is a protocol for differentiating outputs from various well-established cryptographic hash functions, addressing size + encoding considerations.

It is useful to write applications that future-proof their use of hashes, and allow multiple hash functions to coexist. See [jbenet/random-ideas#1](https://github.com/jbenet/random-ideas/issues/1) for a longer discussion.

## Table of Contents

- [Example](#example)
- [Format](#format)
- [Implementations:](#implementations)
- [Visual Examples](#visual-examples)

## Example

Outputs of `<encoding>.encode(multihash(<digest>, <function>))`:

```
# sha1 - 0x11 - sha1("multihash")
111488c2f11fb2ce392acb5b2986e640211c4690073e # sha1 in hex
CEKIRQXRD6ZM4OJKZNNSTBXGIAQRYRUQA47A==== # sha1 in base32
5dsgvJGnvAfiR3K6HCBc4hcokSfmjj # sha1 in base58
ERSIwvEfss45KstbKYbmQCEcRpAHPg== # sha1 in base64

# sha2-256 0x12 - sha2-256("multihash")
12209cbc07c3f991725836a3aa2a581ca2029198aa420b9d99bc0e131d9f3e2cbe47 # sha2-256 in hex
CIQJZPAHYP4ZC4SYG2R2UKSYDSRAFEMYVJBAXHMZXQHBGHM7HYWL4RY= # sha256 in base32
QmYtUc4iTCbbfVSDNKvtQqrfyezPPnFvE33wFmutw9PBBk # sha256 in base58
EiCcvAfD+ZFyWDajqipYHKICkZiqQgudmbwOEx2fPiy+Rw== # sha256 in base64
```

## Format

```
<varint hash function code><varint digest size in bytes><hash function output>
```

Binary example (only 4 bytes for simplicity):

```
fn code  dig size hash digest
-------- -------- ------------------------------------
00010001 00000100 101101100 11111000 01011100 10110101
sha1     4 bytes  4 byte sha1 digest
```

> Why have digest size as a separate number?

Because otherwise you end up with a function code really meaning "function-and-digest-size-code". Makes using custom digest sizes annoying, and is less flexible.

> Why isn't the size first?

Because aesthetically I prefer the code first. You already have to write your stream parsing code to understand that a single byte already means "a length in bytes more to skip". Reversing these doesn't buy you much.

> Why varints?

So that we have no limitation on functions or lengths. Implementation note: you do not need to implement varints until the standard multihash table has more than 127 functions.

> What kind of varints?

An Most Significant Bit unsigned varint, as defined by the [multiformats/unsigned-varint](https://github.com/multiformats/unsigned-varint).

> Don't we have to agree on a table of functions?

Yes, but we already have to agree on functions, so this is not hard. The table even leaves some room for custom function codes.

## Implementations:

- [go-multihash](//github.com/multiformats/go-multihash)
- java-multihash
  - [multiformats/java-multihash](//github.com/multiformats/java-multihash)
  - [comodal/hash-overlay](//github.com/comodal/hash-overlay)
- [js-multihash](//github.com/multiformats/js-multihash)
- [clj-multihash](//github.com/multiformats/clj-multihash)
- rust-multihash
  - [by @dignifiedquire](//github.com/dignifiedquire/rust-multihash)
  - [by @google](//github.com/google/rust-multihash)
- [haskell-multihash](//github.com/LukeHoersten/multihash)
- [python-multihash](//github.com/tehmaze/python-multihash)
- [elixir-multihash](//github.com/zabirauf/ex_multihash), [elixir-multihashing](//github.com/candeira/ex_multihashing)
- [swift-multihash](//github.com/NeoTeo/SwiftMultihash)
- [ruby-multihash](//github.com/neocities/ruby-multihash)
- [MultiHash.Net](//github.com/MCGPPeters/MultiHash.Net)
- [cs-multihash](//github.com/multiformats/cs-multihash)
- [scala-multihash](//github.com/mediachain/scala-multihash)
- [php-multihash](//github.com/Fil/php-multihash)
- [net-ipfs-core](//github.com/richardschneider/net-ipfs-core)

## Visual Examples

These are visual aids that help tell the story of why Multihash matters.

![](/images/multihash.001.jpg)

#### Consider these 4 different hashes of same input

![](/images/multihash.002.jpg)

#### Same length: 256 bits

![](/images/multihash.003.jpg)

#### Different hash functions

![](/images/multihash.004.jpg)

#### Idea: self-describe the values to distinguish

![](/images/multihash.005.jpg)

#### Multihash: fn code + length prefix

![](/images/multihash.006.jpg)

#### Multihash: a pretty good multiformat

![](/images/multihash.007.jpg)

#### Multihash: has a bunch of implementations already

![](/images/multihash.008.jpg)
