---
title: "DNSLink"
menu:
    guides:
        parent: concepts
---

DNSLink uses DNS TXT records to map a domain name (like `ipfs.io`) to an IPFS
address. Because you can edit your DNS records, you can use them to always
point to the latest version of an object in IPFS (remember that an IPFS
object’s address changes if you modify the object). Because DNSLink uses DNS
records, the names it produces are also usually easy to type and read.

A DNSLink address looks like an [IPNS](/guides/concepts/ipns) address, but it
uses a domain name in place of a hashed public key:

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

For example, if you look up `ipfs.io`’s DNS records, you’ll see its DNSLink entry.

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

### Publish via Subdomain

It is possible to publish DNSLink using a special subdomain named `_dnslink`.

This is useful when you want to improve security of automated setup or
delegate control over DNSLink to a third-party without giving full control over
the original DNS zone.

Example: `docs.ipfs.io` may not not have a TXT record, but the page still loads
because TXT record exists for `_dnslink.docs.ipfs.io`:

```
$ dig +noall +answer TXT _dnslink.docs.ipfs.io
_dnslink.docs.ipfs.io.  34  IN  TXT "dnslink=/ipfs/QmeveuwF5wWBSgUXLG6p1oxF3GKkgjEnhA6AAwHUoVsx6E"
```

<!-- Not sure if IPNS is fast enough to mention here
### Linking to IPNS

DNSLink can point at [IPNS](/guides/concepts/ipns) paths as well. IPNS path is
a mutable pointer which  enables you to update your website by publishing
to a PeerID without the need for updating TXT record every time hash changes.
-->

