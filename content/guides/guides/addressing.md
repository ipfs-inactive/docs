---
title: Addressing in Browsers
menu:
    guides:
        parent: guides
weight: 2
---

<!--
Based on the existing spec at:
https://github.com/ipfs/in-web-browsers/blob/2896b7a642011bc92493971232b146e04c9a889c/ADDRESSING.md

Note there are pending tasks to update/extend spec:
https://github.com/ipfs/in-web-browsers/issues/147
-->

This document is a guide on how to address IPFS content paths on the web.

## HTTP Gateways

Gateways are provided strictly for convenience to help tools that speak HTTP but do not speak distributed protocols such as IPFS. They are the first stage on the upgrade path for the web.

### Centralization Concerns

HTTP Gateways has been working well since 2015 but comes with a significant set of limitations related to the centralized nature of HTTP and some of its semantics. Location-based addressing of a gateway depends on both DNS and HTTPS/TLS, which relies on the trust in Certificate Authorities and PKI. In the long term these issues should be mitigated by use of opportunistic protocol upgrade schemes.

### Protocol Upgrade

Tools and browser extensions SHOULD detect IPFS content paths and resolve them directly over IPFS protocol and use HTTP gateway ONLY as a fallback when no native implementation is available to ensure a smooth, backward-compatible transition.

### Gateway Types

#### Path Gateway

In the most basic scheme an URL path used for content addressing is effectively a resource name without a canonical location. HTTP server provides the location part, which makes it possible for browsers to interpret IPFS content path as relative to the current server and just work without a need for any conversion:

```
https://<gateway-host>.tld/ipfs/<cid>/path/to/resource
https://<gateway-host>.tld/ipns/<ipnsid_or_dnslink>/path/to/resource
```


<aside class="alert alert-info">
  In this scheme all pages share a <a href="https://en.wikipedia.org/wiki/Same-origin_policy" target="_blank">single Origin&nbsp;<i class="fas fa-external-link-square-alt fa-sm"></i></a>, which means this type of gateway should be used when site isolation does not matter.
</aside>

Examples:

```
https://ipfs.io/ipfs/bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/wiki/Vincent_van_Gogh.html
https://ipfs.io/ipfs/QmT5NvUtoM5nWFfrQdVrFtvGfKFmG7AHE8P34isapyhCxX/wiki/Mars.html
https://ipfs.io/ipns/tr.wikipedia-on-ipfs.org/wiki/Anasayfa.html
```

#### Subdomain Gateway

When [origin-based security](https://en.wikipedia.org/wiki/Same-origin_policy) perimeter is needed, [CIDv1](https://github.com/ipld/cid#cidv1) in Base32 ([RFC4648](https://tools.ietf.org/html/rfc4648#section-6), no padding) should be used in subdomain:

    https://<cidv1-base32>.ipfs.<gateway-host>.tld/path/to/resource

Example:

    https://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq.ipfs.dweb.link/wiki/
    https://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq.ipfs.cf-ipfs.com/wiki/Vincent_van_Gogh.html


<aside class="alert alert-info">
  Right now this type of gateway requires additional configuration (<a href="https://github.com/ipfs/infra/issues/81#issuecomment-461045160" target="_blank">example for Nginx&nbsp;<i class="fas fa-external-link-square-alt fa-sm"></i></a>), there is an  ongoing work to <a href="https://github.com/ipfs/go-ipfs/issues/5982" target="_blank">add native support in IPFS daemon&nbsp;<i class="fas fa-external-link-square-alt fa-sm"></i></a>.
</aside>

#### DNSLink Gateway

Gateway provided by IPFS daemon understands `Host:` header present in HTTP requests and will check if [DNSLink](/guides/concepts/dnslink) for specified [domain name](https://en.wikipedia.org/wiki/Fully_qualified_domain_name) exists.
If DNSLink is present, gateway will return content from a path resolved via DNS TXT record.
This type of gateway provides full [Origin isolation](https://en.wikipedia.org/wiki/Same-origin_policy).

Example: https://docs.ipfs.io (this website)

For a more complete DNSLink guide, including tutorials, usage examples and FAQs, check out [dnslink.io](https://dnslink.io).


---

## Native URLs

Subdomain convention can be replaced with a native handler. The IPFS URL protocol scheme follows the same requirement of case-insensitive  CIDv1 in Base32 as subdomains:

```
ipfs://{cidv1b32}/path/to/resource
```



IPFS URL does not retain original path, but instead requires a conversion step to/from URI representation:

> `ipfs://{immutable-root}/path/to/resourceA` → `/ipfs/{immutable-root}/path/to/resourceA`  
> `ipns://{mutable-root}/path/to/resourceB` → `/ipns/{mutable-root}/path/to/resourceB`

The first element after double slash is an opaque identifier representing the content root. It is interpreted as an authority component used for Origin calculation, which provides necessary isolation between security contexts of different content trees.

Example:

```
ipfs://bafybeiemxf5abjwjbikoz4mc3a3dla6ual3jsgpdr4cjr3oz3evfyavhwq/wiki/Vincent_van_Gogh.html
```


<aside class="alert alert-info">
  Support for case-insensitive IPNS roots  is a <a href="https://github.com/ipfs/go-ipfs/issues/5287" target="_blank">work in progress&nbsp;<i class="fas fa-external-link-square-alt fa-sm"></i></a>.
</aside>

---

## References


### Technical SPEC for Implementers

The best and up-to-date source of truth about IPFS addressing can be found in [ADDRESSING.md](https://github.com/ipfs/in-web-browsers/blob/master/ADDRESSING.md).

### Background on Address Scheme discussions

The discussions around IPFS addressing has been going on since @jbenet published the [IPFS whitepaper](https://ipfs.io/ipfs/QmR7GSQM93Cx5eAg6a6yRzNde1FQv7uL6X1o4k7zrJa3LX/ipfs.draft3.pdf), with a number of other approaches being  proposed. That design discussion has been going on for a long time, with many lengthy discussions in GitHub issues. A good summary can be found in [this PR&nbsp;<i class="fas fa-external-link-square-alt fa-sm"></i></a>](https://github.com/ipfs/specs/pull/152).

### Future: shared DWEB namespace

DWeb community is exploring the idea of a shared `dweb` namespace to remove the complexity of addressing IPFS and other content-addressed protocols. Currently investigated approaches:

- `dweb://` protocol handler ([arewedistributedyet/issues/28](https://github.com/arewedistributedyet/arewedistributedyet/issues/28))
- `.dweb` special-use top-level domain name ([arewedistributedyet/issues/34](https://github.com/arewedistributedyet/arewedistributedyet/issues/34))
