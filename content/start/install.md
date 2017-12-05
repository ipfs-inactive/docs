---
title: Install IPFS
url: install
---

## Installing from a Prebuilt Package

### Mac OS X and Linux

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

<a class="button button-primary" href="../getting-started" role="button">
  Getting Started with IPFS &nbsp;&nbsp;<i class="fa fa-arrow-right"></i>
</a>

### Windows

After downloading, unzip the archive, and move `ipfs.exe`  somewhere in your `%PATH%`.

Test it out:

```sh
> ipfs help
USAGE:

    ipfs - Global p2p merkle-dag filesystem.
...
```

Congratulations! You now have a working IPFS installation on your computer.

<a class="button button-primary" href="../getting-started" role="button">
  Getting Started with IPFS &nbsp;&nbsp;<i class="fa fa-arrow-right"></i>
</a>


---

## Installing with ipfs-update

`ipfs-update` is a command-line tool to install and upgrade the `ipfs` binary.

### Getting ipfs-update

`ipfs-update` can be downloaded for your platform at: https://dist.ipfs.io/#ipfs-update

If you have a working Go environment (>=1.8), you can also install it with: `go get -u github.com/ipfs/ipfs-update`.

When installing new versions of `ipfs` or upgrading make sure you are using the latest version of `ipfs-update`.

### Installing ipfs with ipfs-update

`ipfs-update versions` lists all the available `ipfs` versions which are available for download:

```
$ ipfs-update versions
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
fetching go-ipfs version v0.4.7-rc1
binary downloaded, verifying...
success!
stashing old binary
installing new binary to /home/hector/go/bin/ipfs
checking if repo migration is needed...
Installation complete!
```

Note that the latest available version may not be stable (i.e. release candidates
in the form `vX.X.X-rcX`). So it is recommended to specify the version you want
to install, for example: `ipfs-update install v0.4.6`.

---

## Building from Source

<div class="message mb">
  <strong>Warning:</strong> In the past you could install IPFS using <code>go get</code>. This
  does not work anymore!
</div>

If you want, you can also build IPFS from source.
If you are on Mac OS X or Linux take a look at [the readme](https://github.com/ipfs/go-ipfs#build-from-source) for install instructions.
If you are on Windows take a look at [this document](https://github.com/ipfs/go-ipfs/blob/master/docs/windows.md) for instructions.

---

## Upgrading IPFS

`ipfs` upgrades (and downgrades) may involve a repository upgrade process performed by the
[fs-repo-migrations](https://dist.ipfs.io/#fs-repo-migrations) tool.

### Upgrading using ipfs-update

`ipfs-update install` will download and run `fs-repo-migrations` when needed, during the installation of
a newer or older `ipfs` version (as explained above). This is the easiest way of upgrading.

<div class="message mb">
  <strong>Warning:</strong> Make sure that the ipfs daemon is not running during an upgrade
</div>


### Upgrading manually

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

---

## Usage

### The repo

`ipfs` uses a global local object repository, added to `~/.ipfs`:

```sh
> ipfs init
initializing ipfs node at /Users/jbenet/.go-ipfs
generating 2048-bit RSA keypair...done
peer identity: Qmcpo2iLBikrdf1d6QU6vXuNb6P7hwrbNPW9kLAH8eG67z
to get started, enter:

  ipfs cat /ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG/readme

```

<div class="alert alert-info">
Note the hash there may differ. If it does, use the one you got.
</div>

Now, try running:

```sh
ipfs cat /ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG/readme
```

You should see something like this:

```
Hello and Welcome to IPFS!

██╗██████╗ ███████╗███████╗
██║██╔══██╗██╔════╝██╔════╝
██║██████╔╝█████╗  ███████╗
██║██╔═══╝ ██╔══╝  ╚════██║
██║██║     ██║     ███████║
╚═╝╚═╝     ╚═╝     ╚══════╝

If you're seeing this, you have successfully installed
IPFS and are now interfacing with the ipfs merkledag!

 -------------------------------------------------------
| Warning:                                              |
|   This is alpha software. use at your own discretion! |
|   Much is missing or lacking polish. There are bugs.  |
|   Not yet secure. Read the security notes for more.   |
 -------------------------------------------------------

Check out some of the other files in this directory:

  ./about
  ./help
  ./quick-start     <-- usage examples
  ./readme          <-- this file
  ./security-notes

```

You can explore other objects in there. In particular, check out `quick-start`:


```sh
ipfs cat /ipfs/QmYwAPJzv5CZsnA625s3Xf2nemtYgPpHdWEz79ojWnPbdG/quick-start
```

Which will walk you through several interesting examples.

### Going Online

Once you're ready to take things online, run the daemon in another terminal:

```sh
> ipfs daemon
Initializing daemon...
API server listening on /ip4/127.0.0.1/tcp/5001
Gateway server listening on /ip4/127.0.0.1/tcp/8080
```

Wait for all three lines to appear.

<div class="alert alert-info">
Make note of the tcp ports you get. if they are different, use yours in the commands below.
</div>

Now, if you're connected to the network,
you should be able to see the ipfs addresses of your peers:

```sh
> ipfs swarm peers
/ip4/104.131.131.82/tcp/4001/ipfs/QmaCpDMGvV2BGHeYERUEnRQAwe3N8SzbUtfsmvsqQLuvuJ
/ip4/104.236.151.122/tcp/4001/ipfs/QmSoLju6m7xTh3DuokvT3886QRYqxAzb1kShaanJgW36yx
/ip4/134.121.64.93/tcp/1035/ipfs/QmWHyrPWQnsz1wxHR219ooJDYTvxJPyZuDUPSDpdsAovN5
/ip4/178.62.8.190/tcp/4002/ipfs/QmdXzZ25cyzSF99csCQmmPZ1NTbWTe8qtKFaZKpZQPdTFB
```

These are a combination of `<transport address>/ipfs/<hash-of-public-key>`.

Now, you should be able to get objects from the network. Try:

```
ipfs cat /ipfs/QmW2WQi7j6c7UgJTarActp7tDNikE4B2qXtFCfLPdsgaTQ/cat.jpg >cat.jpg
open cat.jpg
```

And, you should be able to give the network objects. Try adding one, and then
viewing it in your favorite browser. In this example, we are using `curl`
as our browser, but you can open the IPFS URL in other browsers as well:

```
> hash=`echo "I <3 IPFS -$(whoami)" | ipfs add -q`
> curl "https://ipfs.io/ipfs/$hash"
I <3 IPFS -<your username>
```

Cool, huh? The gateway served a file _from your computer_. The gateway queried
the DHT, found your machine, requested the file, your machine sent it to the
gateway, and the gateway sent it to your browser.

<div class="alert alert-warning">
Note: depending on the state of the network, the `curl` may take a while. The public gateways may be overloaded or having a hard time reaching you.
</div>

You can also check it out at your own local gateway:

```
> curl "http://127.0.0.1:8080/ipfs/$hash"
I <3 IPFS -<your username>
```

By default, your gateway is not exposed to the world, it only works locally.

### The web UI

We also have a web console you can use to check the state of your node.
On your favorite web browser, go to:

> http://localhost:5001/webui

This should bring up a console like this:

<img class="screenshot" alt="Web console connection view" src="/images/webui-connection.png">

Now, you're ready:

<a class="button button-primary" href="../examples" role="button">
  Onward to more Examples &nbsp;&nbsp;<i class="fa fa-arrow-right"></i>
</a>

---

## Troubleshooting

### Help!

If you have any problems, come get live help at
[#ipfs](../#community) or via [the mailing list](../#community).

### Check Go Version

IPFS works with Go 1.7.0 or later.
To check what go version you have installed, type `go version`.
Here's what I get:

```sh
> go version
go version go1.7 linux/amd64
```

If you need to update, it is recommended to install from the
[canonical Go packages](https://golang.org/doc/install/).
Package managers often contain out-of-date Go packages.

### Install FUSE

For more details on setting up FUSE (so that you can mount the filesystem), see [github.com/ipfs/go-ipfs/blob/master/docs/fuse.md](https://github.com/ipfs/go-ipfs/blob/master/docs/fuse.md)
