---
title: "Mutable File System (MFS)"
menu:
    guides:
        parent: concepts
---

Because files in IPFS are content-addressed and immutable, they can be complicated to edit. Mutable File System (MFS) is a tool built into IPFS that lets you treat files like you would a normal name-based filesystem — you can add, remove, move, and edit MFS files and have all the work of updating links and hashes taken care of for you.

MFS is accessed through the [`files`](/api/cli/#ipfs-files) commands in the IPFS CLI and API.

<!-- TODO: add some examples to demonstrate how to use MFS, e.g. creating a directory, adding a file, checking the hash, editing the file, and checking the hash again. -->

This video also provides a good overview of MFS:

{{< youtube FX_AXNDsZ9k >}}
