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
*   the several types of IPFS gateways;
*   their roles in use of IPFS;
*   appropriate situations for use of each type of gateway;
*   situations when you should avoid use of gateways;
*   implementation guidelines.

You should read this document if you want to:
*   understand, at a conceptual level, how gateways fit into the overall use of IPFS;
*   decide whether and what type of gateways to deploy for your use case;
*   understand how to develop and deploy gateways for your use case.

## What is an IPFS gateway?

Errors occur when a browser that does not support IPFS attempts access to IPFS content in the canonical form of
```
ipfs://{contentID}
```
Other tools that rely solely on HTTP(S) (e.g., curl) encounter similar errors in accessing IPFS content in canonical form.

The end stage of IPFS deployment includes native support of IPFS in all popular browsers and tools.
In the interim, upgrading the browser/tool to support IPFS (e.g., through a browser extension) would resolve IPFS content access errors.

However not every user may be permitted to alter, or be capable of altering, their browser/tool configuration. IPFS gateways provide an HTTP(S)-based service for such browsers and tools to access IPFS content.

The canonical form of access to such IPFS gateways is:
```
https://{gatewayURL}/ipfs/{contentID}
```

## Who provides IPFS gateways?

IPFS gateway providers include:
*   Protocol Labs, which deploys the public gateway ipfs.io;
*   Third-party private or public gateways; e.g., `https://cloudfare.com/ipfs`;
*   You, with a gateway installed as a local service on your machine e.g., `localhost:8080`.

Regardless of who deploys it and where, any IPFS gateway resolves access to any IPFS content ID requested via the canonical HTTP form described above.

## What types of IPFS gateways exist?

| gateway type  | sub-type  | functional description    |
| -----------:  | :-------  | :--                       |
| HTTP          | readable  | Only retrieves content (HTTP GET method) |
|               | writeable | Allows data to be added to IPFS (HTTP POST, PUT, DELETE methods) |

<!-- Explain exceptions in Limitations section -->



<!-- So far the above only describes HTTP gateways. Add material for custom URL protocols; e.g., ipns://{peerID}/{path} and dweb://{ipfs address}. See https://docs-beta.ipfs.io/how-to/address-ipfs-on-web/#dweb-addressing-in-brief -->

<!-- How does it relate to the rest of IPFS -->


## When should a gateway be provided, where, and which type of gateway?
<!-- Generic use cases -->
<!-- Which kind of gateway should be used when -->

## When not to provide a gateway


## Limitations


## Implementation status
<!-- current state of technology -->
<!-- roadmap? -->
## Use cases

## Further details
<!-- where to learn more -->


<ContentStatus />
