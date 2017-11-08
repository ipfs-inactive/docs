+++
title = "Installation"
description = "Install IPFS!"
weight = 2
+++

There are currently two main IPFS paskages - go-ipfs and js-ipfs, each has it's unique features

Go-IPFS:

* Reference implementation
* Written in Go
* Scales well
* Best uses:
  * Accessing and serving interplanetary Web
  * Archiving data
  * [[TODO: Add more]]

js-ipfs:

* Written in JavaScript
* Easy to embed in JS-based apps
* Best uses:
  * Application development
  * In-browser uses
  * [[TODO: Add more]]

## Go-IPFS

We recommend installing IPFS from a prebuilt package:

<a class="button button-primary" href="https://dist.ipfs.io/#go-ipfs" role="button">
  Download IPFS for your platform &nbsp;&nbsp;<i class="fa fa-download" aria-hidden="true"></i>
</a>

#### Installation methods

* [Installing from a Prebuilt Package](#installing-from-a-prebuilt-package)
* [Installing with ipfs-update](#installing-with-ipfs-update)
* [Building from source](#building-from-source)
* [Upgrading IPFS](#upgrading-ipfs)
* [Troubleshooting](#troubleshooting)

---

### Installing from a Prebuilt Package

#### Mac OS X and Linux

After downloading, untar the archive, and move the `ipfs` binary somewhere in your executables `$PATH`:

```sh
tar xvfz go-ipfs.tar.gz
mv go-ipfs/ipfs /usr/local/bin/ipfs
```

Test it out:

```sh
> ipfs help
USAGE:

    ipfs - Global p2p merkle-dag filesystem.
...
```

Congratulations! You now have a working IPFS installation on your computer.

<a class="button button-primary" href="../basic-usage" role="button">
  Getting Started with IPFS &nbsp;&nbsp;<i class="fa fa-arrow-right"></i>
</a>

#### Windows

After downloading, unzip the archive, and move `ipfs.exe`  somewhere in your `%PATH%`.

Test it out:

```sh
> ipfs help
USAGE:

    ipfs - Global p2p merkle-dag filesystem.
...
```

### Installing with ipfs-update

`ipfs-update` is a command-line tool to install and upgrade the `ipfs` binary.

#### Getting ipfs-update

`ipfs-update` can be downloaded for your platform at https://dist.ipfs.io/#ipfs-update,
if you have a working Go environment (>=1.8), you can also install it with: `go get -u github.com/ipfs/ipfs-update`.

When installing new versions of `ipfs` or upgrading make sure you are using the latest version of `ipfs-update`.

#### Installing ipfs with ipfs-update

`ipfs-update versions` lists all the available `ipfs` versions which are available for download:

```
$ ipfs-update-versions
v0.3.2
v0.3.4
v0.3.5
v0.3.6
v0.3.7
v0.3.8
v0.3.9
v0.3.10
v0.3.11
v0.4.0
v0.4.1
v0.4.2
v0.4.3
v0.4.4
v0.4.5
v0.4.6
v0.4.7-rc1
```


`ipfs-update install latest` will install the latest available version:

```
$ ipfs-update install latest
fetching go-ipfs version v0.4.11
binary downloaded, verifying...
success!
stashing old binary
installing new binary to /home/hector/go/bin/ipfs
checking if repo migration is needed...
Installation complete!
```

Note that the latest available version may not be stable (i.e. release candidates
in the form `vX.X.X-rcX`). So it is recommended to specify the version you want
to install, for example: `ipfs-update install v0.4.11`.

---

### Building from Source

<div class="message mb">
  <strong>Warning:</strong> In the past you could install IPFS using <code>go get</code>. This
  does not work anymore!
</div>

If you want, you can also build IPFS from source.
If you are on Mac OS X or Linux take a look at [the readme](https://github.com/ipfs/go-ipfs#build-from-source) for install instructions.
If you are on Windows take a look at [this document](https://github.com/ipfs/go-ipfs/blob/master/docs/windows.md) for instructions.

---

### Upgrading IPFS

`ipfs` upgrades (and downgrades) may involve a repository upgrade process performed by the
[fs-repo-migrations](https://dist.ipfs.io/#fs-repo-migrations) tool.

#### Using ipfs-update

`ipfs-update install` will download and run `fs-repo-migrations` when needed, during the installation of
a newer or older `ipfs` version (as explained above). This is the easiest way of upgrading.

<div class="message mb">
  <strong>Warning:</strong> Make sure that the ipfs daemon is not running during an upgrade
</div>

#### Manually

In order to perform a manual upgrade of `ipfs`, you will need to manually run any repository migrations. The
procedure is as follows:

* Stop the `ipfs` daemon if it is running
* Optionally backup your `ipfs` data folder (i.e. `cp -aL ~/.ipfs ~/.ipfs.bk`)
* Download and install the latest version of `ipfs` from [https://dist.ipfs.io/#go-ipfs](https://dist.ipfs.io/#go-ipfs)
* Run `ipfs daemon`.

When a repository migration is necessary, `ipfs` will inform the user, download and install `fs-repo-migrations`
and perform the upgrade. If you wish the procedure to happen unattended, launch the daemon with the `--migrate`
flag.

Migrations can be also run manually by downloading the latest version of `fs-repo-migrations`
from [https://dist.ipfs.io/#fs-repo-migrations](https://dist.ipfs.io/#fs-repo-migrations) and
[following these instructions](https://github.com/ipfs/fs-repo-migrations/blob/master/run.md).
