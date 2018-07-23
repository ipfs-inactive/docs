---
title: "IPNS"
menu:
    guides:
        parent: concepts
---

Inter-Planetary Name System (IPNS) is a system for creating and updating mutable links to IPFS content. Since objects in IPFS are content-addressed, their address changes every time their content does. That’s useful for a variety of things, but it makes it hard to get the latest version of something.

A name in IPNS is the hash of a public key. It is associated with a record containing information about the hash it links to that is signed by the corresponding private key. New records can be signed and published at any time.

When looking up an IPNS address, use the `/ipns/` prefix:

```
/ipns/QmSrPmbaUKA3ZodhzPWZnpFgcPMFWF4QsxXbkWfEptTBJd
```

<!-- TODO: more description of creating and publishing a name -->

IPNS is not the only to create mutable addresses on IPFS. You can also use [DNSLink](/guides/concepts/dnslink) (which is currently much faster than IPNS and also uses more readable names). Other community members are exploring ways to use blockchains to store common name records.
