---
title: Snapshots
menu:
    guides:
        parent: examples
weight: 10
beta_equivalent: how-to/take-snapshot
summary: A quick look at how IPFS can be used to take basic snapshots of files
---

<div class="alert alert-info">
Our interactive tutorials help you learn about the the decentralized web by writing code and solving challenges:
<a class="button button-primary" href="https://proto.school/#/tutorials" role="button" target="_blank">Open Tutorials at ProtoSchool</a> &nbsp;<i class="fa fa-external-link-square-alt"></i>
</div>

Let's take a quick look at how IPFS can be used to take basic *snapshots* of files — an action that enables you to access those files later in the same state as they were when you "snapshotted" them.

Save your directory:
```sh
$ ipfs add -r ~/code/myproject
```

Note the hash:
```sh
$ echo $hash `date` >> snapshots
```


Or all at once:
```sh
$ echo `ipfs add -q -r ~/code/myproject | tail -n1` `date` >> snapshots
```
(Note: the `-q` makes the output only contain the hashes, and piping through
`tail -n1` ensures that only the hash of the top folder is output.)

Make sure to have the placeholders for the mount points:
```sh
$ sudo mkdir /ipfs /ipns
$ sudo chown `whoami` /ipfs /ipns
```

You will need to have `FUSE` (Filesystem in Userspace) installed on your machine in order to be able to `mount` directories from the ipfs. You can find instructions for how to install `FUSE` [in the `go-ipfs` docs](https://github.com/ipfs/go-ipfs/blob/master/docs/fuse.md).


View your snapshots live:
```sh
$ ipfs mount
$ ls /ipfs/$hash/

# can also

$ cd /ipfs/$hash/
$ ls
```

Through the FUSE interface, you'll be able to access your files exactly as
they were when you took the snapshot.

By [whyrusleeping](http://github.com/whyrusleeping)
