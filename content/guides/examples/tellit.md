# Introduction to Tellit

Internet is made out of information: users’ digital footprint, communication, posts and more. Are we facing information sovereignty or a products based structure[¹](https://inventaire.io/items/4b9a11d8a32aabab8b2e417f3e490a66)? Think about all the personal information that is sold and collected on social networks and other services. Freedom of the software implies believing in equality and transparency, does it engage with data trading? The reality of digital surveillance is well known but widely ignored, as it’s uncomfortable and difficult to handle.

IPFS (Interplanetary File System) is a peer to peer hypermedia protocol which offers the posibility of a fair, resilient and decentralized solution against internet censorship and other main problems of the current context of digital rights. As IPFS hashes the files **but doesn't encrypts them**, there's a possible security enhancement about encrypting the files beforehand either using a key pair or a passphrase. For this purpose exists [Tellit](https://gitlab.com/terceranexus6/tellit/tree/master). 


The goal of this project is to create an intuitive tool for Linux terminal that would allow us to encrypt, decrypt, upload encrypted files to IPFS and get files from it. Also, it helps to monitor the system and create encrypted backups. It's specially aimed at journalists and activists as they are the main target of this kind of digital harassment.

The script only depends on [openssl](https://www.openssl.org/) and **IPFS**.

# IPFS and Openssl

Forst of all, we should check `openssl version`. If the version doesn't show up and we get an error, then we shall install it.
```
# apt install openssl
# apt update
```

Now we configure IPFS as described in the [official documentation](https://docs.ipfs.io/).

# Getting to it

## Key pair managing and encryption

The script allow you to encrypt and decrypt files using openssl choosing either a keypair or a passphrase. They can either encrypt them and later use IPFS or use an inline command to do it all at once, as shown below. It is all explained in the [official tool documentation](https://gitlab.com/terceranexus6/tellit/wikis/First-steps).

## IPFS uploading

Now, let's imagine we want to upload our file file.txt to IPFS. If we use the regular `ipfs` command we will upload it as a hash **without encrypting it**. We can encrypt+upload (if we correctly configured it) using
```
$ ./tellit-c.sh --ipfs --add file.txt -e trial_id-XXX/trial
```
In this case we are using a key pair previously created using `$ ./tellit-c.sh --pripu -o trial`. If you want to use a password instead, we would write:
```
$ ./tellit-c --ipfs --add file.txt -pass example_password
```
Now it should be done and uploaded! Even if someone has the hash, if they don't have the password they won't be able to see it, or if you use the keypair, only you will be able to use it (as you shouldn't give the private key to anyone).

This script trust on IPFS as it has been revealed as an anti-censorship tool and its philosophy support the open source community ambitions. We hope to keep improving it for the ones who most need it.
