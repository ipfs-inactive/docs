---
title: Playing with the Network
menu:
    guides:
        parent: examples
weight: 9
beta_equivalent: how-to/observe-peers
---

<div class="alert alert-info">
Our interactive tutorials help you learn about the the decentralized web by writing code and solving challenges:
<a class="button button-primary" href="https://proto.school/#/tutorials" role="button" target="_blank">Open Tutorials at ProtoSchool</a> &nbsp;<i class="fa fa-external-link-square-alt"></i>
</div>


IPFS is all about networking! Included are a useful set of commands
to aid in observing the network.

See who you're directly connected to:

```sh
ipfs swarm peers
```

Manually connect to a specific peer. If the peer below doesn't work, choose one from the output of `ipfs swarm peers`.

```sh
ipfs swarm connect /ip4/104.236.176.52/tcp/4001/ipfs/QmSoLnSGccFuZQJzRadHn95W2CrSFmZuTdDWP8HXaHca9z
```

Search for a given peer on the network:

```sh
ipfs dht findpeer QmSoLnSGccFuZQJzRadHn95W2CrSFmZuTdDWP8HXaHca9z
```

By [whyrusleeping](http://github.com/whyrusleeping)
