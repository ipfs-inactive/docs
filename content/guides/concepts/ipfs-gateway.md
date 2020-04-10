---
title: IPFS Gateway
sidebarDepth: 0
issueUrl: https://github.com/ipfs/docs/issues/93
description: Learn why gateways are an important part of using IPFS in conjunction with the legacy web.
related:
  'IPFS Docs: Address IPFS on the Web': /how-to/address-ipfs-on-web/
  'IPFS public gateway checker': https://ipfs.github.io/public-gateway-checker/
  'GitHub repo: Gateway summary from go-ipfs': https://github.com/ipfs/go-ipfs/blob/master/docs/gateway.md
  'Article: Solving the IPFS Gateway Problem (Pinata)': https://medium.com/pinata/the-ipfs-gateway-problem-64bbe7eb8170
  'Tutorial: Setting up an IPFS gateway on Google Cloud Platform (Stacktical)': https://blog.stacktical.com/ipfs/gateway/dapp/2019/09/21/ipfs-server-google-cloud-platform.html
---

# IPFS Gateway

This document discusses:
* the several types of IPFS gateways;
* their roles in use of IPFS;
* appropriate situations for use of each type of gateway;
* situations when you should avoid use of gateways;
* implementation guidelines.

You should read this document if you want to:
* understand, at a conceptual level, how gateways fit into the overall use of IPFS;
* decide whether and what type of gateways to deploy for your use case;
* understand how to develop and deploy gateways for your use case.

## What is an IPFS gateway?

Errors occur when a browser that does not support IPFS attempts access to IPFS content in the canonical form of
```
ipfs://{contentID}
```
Other tools that rely solely on HTTP(S) (e.g., curl) encounter similar errors in accessing IPFS content in canonical form.

The end stage of IPFS deployment includes native support of IPFS in all browsers/tools.

In the interim, upgrading the browser/tool to support IPFS (e.g., through a browser extension) would resolve IPFS content access errors.

However not every user may be permitted to alter, or be capable of altering, their browser/tool configuration.
IPFS gateways provide an HTTP(S)-based service for such browsers and tools to access IPFS content.

The canonical form of access to IPFS gateways is:
```
https://{gatewayURL}/ipfs/{contentID}
```

### IPFS gateway types

IPFS gateways include:
* the public gateway ipfs.io;
* private or public gateways provided by third parties; e.g., `https://cloudfare.com/ipfs`;
* a gateway installed as a local service on your machine e.g., `localhost:8080`.

Regardless of who deploys it and where, any IPFS gateway resolves access to any IPFS content ID requested via the canonical HTTP form described above.
<!-- Explain exceptions in Limitations section -->

<!-- Introduce concept of writable gateways; see https://discuss.ipfs.io/t/writeable-http-gateways/210 -->

<!-- So far the above only describes HTTP gateways. Add material for custom URL protocols; e.g., ipns://{peerID}/{path} and dweb://{ipfs address}. See https://docs-beta.ipfs.io/how-to/address-ipfs-on-web/#dweb-addressing-in-brief -->

### Limitations
<!-- * not distributed
* CID verification -->


<!-- verify aligns with defined term in glossary (#56),
  which as of 2020 Jan 16 is empty -->
<!-- How does it relate to the rest of IPFS -->
<!-- Gateway is great for playing well with the outside world,
  but you're really only getting part of the full IPFS goodness.
  Let's emphasize gateway as a gateway drug ;) -->
<!-- Also, important to incorporate documentation on writable gateways
  which is here: https://discuss.ipfs.io/t/writeable-http-gateways/210 -->
<!-- Lidl:
  There is also a short section on HTTP Gateways I wrote at
  https://docs.ipfs.io/guides/guides/addressing/#http-gateways which could be reused/expanded into a dedicated
  article about Gateways.

  I believe it is important to recognize three types of HTTP gateways:

  DNSLink gateway (eg. en.wikipedia-on-ipfs.org)
  (when domain DNS A record points at IP with go-ipfs and DNS TXT record points at IPFS content path)
  Path gateway (ipfs.io/ipfs/bafy...)
  Subdomain gateway (bafy...ipfs.dweb.link)
  this is wip, we want to support this natively so more people can run it: ipfs/go-ipfs#6498
  DNSLink gateway is useful for "private/personal" hosting and the other two are more like "public" service (here
  is a community list of public ones). -->

## Implementation status
<!-- current state of technology -->
<!-- roadmap? -->

## When should a gateway be provided?
<!-- Generic use cases -->
<!-- Which kind of gateway should be used when -->

## When not to provide a gateway

## Use cases

## Further details
<!-- where to learn more -->

<!-- ### Olli's on-boarding document
The HTTP to IPFS Gateway

The gateway hosted at https://ipfs.io allows browsers and tools that speak http to access content from the IPFS network. It provides the canonical way to address IPFS content via http scheme urls.

A request for:

https://ipfs.io/ipfs/QmZULkCELmmk5XNfCgTnCyFgAVxBRBXyDHGGMVoLFLiXEN

...will hit the gateway and get forwarded to an IPFS node, which fetches the block for the CID QmZULkCELmmk5XNfCgTnCyFgAVxBRBXyDHGGMVoLFLiXEN and returns the content via http.

The gateway lets you to ask our servers to do an IPFS lookup for you. It provides an upgrade path towards full IPFS support; tools that speak http can fetch data via it's content-address via the gateway today.

When they are ready they can embed an IPFS node and fetch the same content directly from the network. Developers are encouraged to opportunistically upgrade http urls that point to the ipfs.io gateway to the equivalent ipfs request. The magic of content-addressing means you'll get exactly the same data whether you request it via http or via ipfs.

So, the gateway provides "IPFS as a service". We'd like everyone to run their own IPFS node, and fully decentralize the web, but until that time, we'll be running a large piece of critical network infrastructure, to help folks make the transition.

A centralized service for a decentralized web?

Any ipfs node can run a local http-to-ipfs gateway. Folks who run a local ipfs daemon can use their own gateway, at https://localhost:8080 by default, to allow their browser and other tools to fetch content-addressed data over http but using their ipfs node to find and fetch it. The ipfs-companion web extension can be used to automatically upgrade ipfs gateway http urls to be redirected to your local gateway.

When folks use their own local gateway, our gateway infrastructure plays no part in the request. We want everyone to be able to use ipfs in this manner.

Our gateway is made up of regular go-ipfs nodes. Again, due to the magic of content-addressing, the gateway nodes we run are fungible; you can swap the service provided by one gateway node for any other. Other orgs have stood up their own ipfs gateways; Cloudflare being a notable one, and the decentralizing principle behind all this is that you can get the same content-addressed data from any of them...

$ echo hello | ipfs add -q
QmZULkCELmmk5XNfCgTnCyFgAVxBRBXyDHGGMVoLFLiXEN

$ ipfs cat QmZULkCELmmk5XNfCgTnCyFgAVxBRBXyDHGGMVoLFLiXEN
hello

$ curl https://ipfs.io/ipfs/QmZULkCELmmk5XNfCgTnCyFgAVxBRBXyDHGGMVoLFLiXEN
hello

$ curl https://cloudflare-ipfs.com/ipfs/QmZULkCELmmk5XNfCgTnCyFgAVxBRBXyDHGGMVoLFLiXEN
hello
You can see the video version of this explanation over here https://www.youtube.com/watch?v=-cW7QCQkhKo

So, anyone can run a gateway, but we offer up https://ipfs.io as the canonical gateway, as a public service.

Most critically we want to normalise using and publishing https://ipfs.io/ipfs/<cid> style addresses, as it tools that understand ipfs to upgrade them to ipfs, while tools that don't can still fetch the content.

It is assumed that a proliferation of gateway providers and ipfs paths at many different domains would make it less clear to end users and developers what was going on (although ipfs-companion already does a great job of redirecting ipfs addresses from any valid domain).

We also offer it as a "trustable" ipfs gateway. We cannot automatically verify that another gateway is always serving the correct content for a given cid. Using a gateway means placing your trust in the service operator that they will not tamper with the response. Content that is fetched via an ipfs node is always cryptographically validated, but once we switch to using the http-to-ipfs gateway of another node, we lose the end-to-end validation. There is currently no automatic mechanism for validating that an http-to-ipfs gateway is serving the correct content for a given cid, so we provide ipfs.io as the reference gateway. -->

<ContentStatus />
