---
title: Playing Videos
menu:
    guides:
        parent: examples
weight: 8
beta_equivalent: foo/bar
---

<div class="alert alert-info">
Our interactive tutorials help you learn about the the decentralized web by writing code and solving challenges:
<a class="button button-primary" href="https://proto.school/#/tutorials" role="button" target="_blank">Open Tutorials at ProtoSchool</a> &nbsp;<i class="fa fa-external-link-square-alt"></i>
</div>

IPFS can be used to store and play videos. Suppose we add a video:

```
ipfs add -q sintel.mp4 | tail -n1
```

Take the resulting hash, You can view it a couple different ways:

On the command line:
```
ipfs cat $vidhash | mplayer -vo xv -
```

Via local gateway:
```
mplayer http://localhost:8080/ipfs/$vidhash

# or open it up in a tab in chrome (or firefox)

chromium http://localhost:8080/ipfs/$vidhash
```
(Note: the gateway method works with most video players and browsers)

By [whyrusleeping](http://github.com/whyrusleeping)
