---
title: "Peers and Peer IDs"
menu:
    guides:
        parent: concepts
---

The core of any distributed system is the concept of peers.

In IPFS, the _content identifier_ points to a specific piece of content, while a _peer_ is a node on the network where the content can be found. Think of the peer as a data host where IPFS can find the content you request.

A piece of content may be available across many different peers. With content addressing, the decentralized web can find that unique piece of content across any of the peers that contain it.

Peers use unique identifiers - the _peer ID_ - to authorize and encrypt communication across peer nodes. You need a _peer ID_ to host data across IPFS.

## Benefits of peer-to-peer interaction

The peer-to-peer aspect of IPFS provides many of the benefits of the decentralized web.

**Increased efficiency and availability**

Users can access data from any peer that has the data they want, increasing efficiency and ensuring resources are always available.

**Protection for important data**

Data need not become endangered, because anyone can hold a copy of the data they care about. You don't have to worry about someone turning off the servers where your data is hosted; _as a peer in IPFS, you are one of the hosts_.

**Immutable links**

In IPFS, when any node contains a specific piece of content, everyone's links to that content work. If someone were to destroy all the copies of the content on the network, but one single node containing the content comes onto the network, this restores the availability of that content.

**Distributed load**

Any peer that contains a piece of content can serve it. When multiple peers contain the content, the load of accessing that content is distributed across those peers.

**Unstable or partitioned networks**

You don't need a stable connection to the entirety of the web to access content through IPFS. If your node can connect to at least one node with the content you want, you'll have access to that content.


## Initializing a new peer in IPFS

IPFS uses [RSA cryptography](https://en.wikipedia.org/wiki/RSA_(cryptosystem)) to generate a key pair for authentication and encryption; a _public key_ you can share, and a _private key_ you keep secret. You'll see this in our [Getting Started guide]({{< relref "/introduction/usage.md" >}}), under: [Initialize the Repository]({{< relref "/introduction/usage.md#initialize-the-repository" >}}).

```
$ ipfs init
initializing IPFS node at ~/.ipfs/
generating 2048-bit RSA keypair...done
peer identity: Qm...
```

IPFS uses the [SHA-256 multihash](https://en.wikipedia.org/wiki/SHA-2) of the peer's public key as its cryptographic peer ID. Before you can use the public key, though, you'll need to encode it.

To do this, you'll convert a [Protocol Buffer](https://developers.google.com/protocol-buffers/) (Google's data interchange format) that contains a serialized representation of the public key (in [RSA DER format](https://tls.mbed.org/kb/cryptography/asn1-key-structures-in-der-and-pem)) into a [base64-encoded string](https://en.wikipedia.org/wiki/Base64).

### Example: Setting up a peer in Python

In Python, this process looks something like this:

#### Prepare a Python class to encode and parse protocol buffer data

First, you need to prepare a Python class to encode and parse protocol buffer data.

Install the necessary Python packages using `pip`:

```
$ pip install base64 base58 cryptography pyrobuf
```

Set up the main imports using boilerplate code so you have all the functions and classes you need:

```
import base58, base64
from pyrobuf_util import to_varint
from cryptography.hazmat.primitives.asymmetric.rsa import (
    generate_private_key,
    RSAPublicKeyWithSerialization,
    RSAPrivateKeyWithSerialization
)
from cryptography.hazmat.primitives.hashes import SHA256, Hash
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives.serialization import (
    Encoding,
    PublicFormat,
    load_der_private_key,
    load_der_public_key
)
```

Download the [`crypto.proto` definition file](https://raw.githubusercontent.com/libp2p/go-libp2p-crypto/master/pb/crypto.proto) from the IPFS project, and compile it into a Python class that allows you to encode and parse the protocol buffer data.

If you prefer not to do this manually, the Python package [`pyrobuf`](https://github.com/appnexus/pyrobuf) automates this process. To use `pyrobuf` to automate this, run this from your command-line/terminal:

```
$ wget https://raw.githubusercontent.com/libp2p/go-libp2p-crypto/master/pb/crypto.proto
$ pyrobuf --install crypto.proto
```

Jump back to the script (your Python [REPL](https://en.wikipedia.org/wiki/Read–eval–print_loop)) and add these imports:

```
from crypto_proto import PrivateKey, PublicKey, RSA
```

#### Get a Public Key

Next, you'll need to get or generate a public key. You can do this in one of two ways:

[Grab the Public Key from an IPFS install](#grab-the-public-key-from-an-ipfs-install)

[Generate a new RSA keypair](#generate-a-new-rsa-keypair)

##### Grab the Public Key from an IPFS install

If you've already got IPFS installed and the daemon running, you can copy the `Public Key` by using this in your terminal:

```
ipfs id --format="Peer Id: <id>\nPublic Key: <pubkey>"
```

And then adding this to your script:

```
public_buf = base64.b64decode(b"...")
```

From here, you can [compute the SHA256 hash of the protobuf-encoded public key to compute a digest](#compute-the-sha256-hash).

##### Generate a new RSA keypair

Alternately, you can generate a new RSA keypair with 2048 bytes (IPFS's current default for security) and a default `public_exponent`:

```
private_key = generate_private_key(
    public_exponent=65537,
    key_size=2048,
    backend=default_backend()
)
```

Now you've got a new RSA private key. From here, you'll need to grab the public key, which you'll use to form the peer's id:

```
public_key = private_key.public_key()
```

But before you can encode the key as a protobuf, you'll need to export it to a DER-encoded ASN.1 SubjectPublicKeyInfo structure:

```
b = public_key.public_bytes(
 encoding=Encoding.DER,
 format=PublicFormat.SubjectPublicKeyInfo
)
```

Almost there! Now you can encode the public key bytes into a protobuf using the classes created by the `pyrobuf` library:

```
proto = PublicKey()
proto.Type = RSA
proto.Data = b
public_buf = proto.SerializeToString()
```

From here, you can [compute the SHA256 hash of the protobuf-encoded public key to compute a digest](#compute-the-sha256-hash).

#### Compute the SHA256 hash

You'll compute the SHA256 hash of the protobuf-encoded public key to compute a digest:

```
h = Hash(SHA256(), backend=default_backend())
h.update(public_buf)
digest = h.finalize()
```

Then, compute a multihash of the digest. IPFS currently defaults to SHA2-256. If you're curious about multihashes, you can read up at [Multiformats.io](https://multiformats.io).

```
hash_function = 0x12
length = len(digest)
multihash = to_varint(hash_function) + to_varint(length) + digest
```

Finally, base58-encode the multihash and print it out:

```
print(base58.b58encode(bytes(multihash)).decode())
```

This gives you something that starts with `Qm` and contains your _peer ID_, which you saw as `peer identity:` in the output of the `ipfs init` command we ran at the beginning.


**Sources**

Farmer, Carson. "How IPFS peer nodes identify each other on the distributed web." _Medium_ (blog), July 10, 2018, https://medium.com/textileio/how-ipfs-peer-nodes-identify-each-other-on-the-distributed-web-8b5b6476aa5e.

The Decentralized Web Primer. https://flyingzumwalt.gitbooks.io/decentralized-web-primer/
