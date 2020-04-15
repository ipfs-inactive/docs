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

## 1. What is an IPFS gateway?

Errors occur when a browser that does not support IPFS attempts access to IPFS content in the canonical form of
```
ipfs://{contentID}
```
Other tools that rely solely on HTTP(S) (e.g., curl) encounter similar errors in accessing IPFS content in canonical form.

The end stage of IPFS deployment includes native support of IPFS in all popular browsers and tools.
In the interim, upgrading the browser/tool to support IPFS (e.g., through a browser extension such as [IPFS Companion for Firefox](https://addons.mozilla.org/en-US/firefox/addon/ipfs-companion/) or [IPFS Companion for Chrome](https://chrome.google.com/webstore/detail/ipfs-companion/nibjojkomfdiaoajekhjakgkdhaomnch)) would resolve IPFS content access errors.

However, not every user may be permitted to alter — or be capable of altering — their browser/tool configuration.
IPFS gateways provide an HTTP(S)-based service for such browsers and tools to access IPFS content.

The canonical form of access to such IPFS gateways is:
```
https://{gatewayURL}/ipfs/{contentID}
```

## 2. Who provides IPFS gateways?

IPFS gateway providers include:
*   Protocol Labs, which deploys the public gateway ipfs.io;
*   Third-party private or public gateways; e.g., `https://cloudfare.com/ipfs`;
*   You, with a gateway installed as a local service on your machine e.g., `localhost:8080`.

Regardless of who deploys it and where, any IPFS gateway resolves access to any IPFS content ID requested via the canonical HTTP form described above.

## 3. What types of IPFS gateways exist?

### 3.1 Read-only and writeable gateways
The discussion above illustrated the use of read-only HTTP(S) gateways to fetch content; i.e., supports HTTP(S) GET.

_Writeable_ HTTP(S) gateways also support POST, PUT and DELETE methods to manage content in IPFS.

### 3.2 Gateway types

| gateway type  | sub-type  | functional description    |
| -----------:  | :-------  | :--                       |
| HTTP          | readable  | Retrieve ipfs:// content (HTTP GET method) |
|               | writeable | Write ipfs:// content (HTTP POST, PUT, DELETE methods) |
| IPLD          |           |  Read/write ipld:// content                         |
| IPNS  |   | Read/write ipns:// content  |
| DWEB   |   | Read/write dweb:// content  |

## 4. When should a gateway be provided, where, and which type of gateway?

### 4.1 Firewalled networks
Running [IPFS Desktop](https://github.com/ipfs-shipyard/ipfs-desktop#ipfs-desktop) or a standalone IPFS node within a browser/tool triggers connection attempts to other IPFS peers.
Private network administrators may treat such connection attempts as potential security vulnerabilities.
IPFS gateway servers located inside the private network and running a trusted code base provide an alternative architecture for read/write access to externally-hosted IPFS content.

## 5. When not to employ a gateway

### 5.1 Delay-sensitive applications
Any gateway introduces delay in completing desired actions.
Faster execution occurs when using methods close to the top of the following list instead of those toward the bottom:
*   native IPFS node embedded within the app.
*   IPFS extension to app.
*   gateway installed as a local daemon, with redirection of requests
from app to the local service.
*   public/private gateways.

### 5.2 End-to-end cyptographic validation required
Because of third-party gateway vulnerabilities outlined in §6.1 below, apps requiring end-to-end validation of content read/write should avoid gateways when possible.
If the app must employ an extenal gateway, such apps should use ipfs.io or a trusted third-party.

## 6. Limitations

### 6.1 Centralization


### 6.2 Gateway man-in-the-middle (MIM) vulnerability
Employing a public or private HTTP(S) gateway sacrifices end-to-end cryptographic validation of delivery of the correct content.
Consider the case of a browser fetching content with the URL `https://anipfsgateway.org/ipfs/{cid}`.
A compromised `anipfsgateway.org` provides man-in-the-middle vulnerabilities, including:
*   Substituting false content in place of the actual content retrieved via the CID;
*   Diverting a copy of the query and response, as well as the IP address of the querying browser, to a third party.

Similarly, a compromised writeable gateway may inject falsified content into the IPFS network, returning a CID which the user believes (incorrectly) to refer to the true content.
For example, a compromised writeable gateway user Alice POSTs `balance: 123.45`, but the gateway stores `balance: 0.00` and returns to Alice a CID for the falsified content.
Alice gives Bob this CID.
Bob fetches the content with this CID and cryptographically validates `balance: 0.00`.

To partially address this exposure you may wish to use the public gateway ipfs.io as an independent, trusted reference.

## 7. Implementation status

## 8. Use cases

## 9. Further details

<ContentStatus />
