---
title: "DNSLink"
menu:
    docs:
        parent: concepts
---

DNSLink uses DNS records to map a domain name (like `ipfs.io`) to an IPFS address. Because you can edit your DNS records, you can use them to always point to the latest version of an object in IPFS (remember that an IPFS object’s address changes if you modify the object). Because DNSLink uses DNS records, the names it produces are also usually easy to type and read.

A DNSLink address looks like an [IPNS](/concepts/ipns) address, but it uses a domain name in place of a hashed public key:

```
/ipns/ipfs.io
```

Just like normal IPFS addresses, they can include links to other files:

```
/ipns/ipfs.io/media/
```

When an IPFS client or node attempts to resolve that address, it looks for a `TXT` record for `ipfs.io` with content like:

```
dnslink=/ipfs/<CID for your content here>
```

For example, if you look up ipfs.io’s DNS records, you’ll see its DNSLink entry (see “answer section” at the bottom):

```
$ dig +noall +answer TXT ipfs.io
ipfs.io.		59	IN	TXT	"dnslink=/ipfs/QmYNQJoKGNHTpPxCBPh9KkDpaExgd2duMa3aF6ytMpHdao"
```

Based on that, this address:

```
/ipns/ipfs.io/media/
```

Will get you this block:

```
/ipfs/QmYNQJoKGNHTpPxCBPh9KkDpaExgd2duMa3aF6ytMpHdao/media/
```
