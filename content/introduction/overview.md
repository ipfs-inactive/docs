---
title: What is IPFS?
weight: 1
---

Welcome! If you’re new to IPFS, you’ve come to the right place. Here is a quick overview of what IPFS is, how it works, and how to use it.

## IPFS is a distributed system for storing and accessing files, websites, applications, and data.

What does that mean, exactly? Let’s say you’re doing some research on aardvarks. (Just roll with it; aardvarks are cool! Did you know they can tunnel 3 feet in only 5 minutes?) You might start by visiting the wikipedia page on aardvarks at:

```
https://en.wikipedia.org/wiki/aardvark
```

When you put that URL in your browser’s address bar, your computer asks one of Wikipedia’s computers, which might be somewhere on the other side of the country (or even the planet), for the aardvark page.

However, if you use IPFS, your computer asks to get that page like this:

```
/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/aardvark.html
```

IPFS knows how to find that sweet, sweet aardvark information by its [contents](/guides/concepts/cid/), not its location (more on that, which is called content-addressing, below!). The IPFS-translated version of the aardvark info is represented by that string of numbers in the middle of the URL, and instead of asking one of Wikipedia's computers for the page, your computer uses IPFS to ask lots of computers around the world to share the page with you. It can get your aardvark info from anyone who has it, not just Wikipedia.

And, when you use IPFS, you don’t just download files from someone else — your computer also helps distribute them. When your friend a few blocks away needs the same Wikipedia page, they might be as likely to get it from you as your neighbor or anyone else using IPFS.

IPFS makes this possible for not only web pages, but also any kind of file a computer might store, whether it’s a document, an e-mail, an MP3 file, or even a database record.


## So why does that matter?

Making it possible to download a file from many locations that aren’t managed by one organization…

- **Makes it hard for a website to go offline.** If someone attacks Wikipedia’s web servers or an engineer at Wikipedia makes a big mistake that causes their servers to catch fire, you can still get the same page from somewhere else.

- **Makes it harder for authorities to censor content.** Because files on IPFS can come from many places, it’s very hard for authorities (whether they’re states, corporations, or someone else) to block things. In 2017, Turkey blocked Wikipedia and Spain blocked access to Catalonian independence sites. We hope IPFS can prevent actions like those.

- **Can speed up the web when you’re far away or disconnected.** If you can retrieve a file from someone nearby instead of hundreds or thousands of miles away, you can get it faster. (Organizations with enough money and expertise can do this with CDNs ([content distribution networks](https://en.wikipedia.org/wiki/Content_delivery_network)) or multiple data centers, but IPFS aims to make this possible for everyone.) That’s especially valuable if your community is networked locally, but doesn’t have a good connection to the wider internet.

That last point is actually where IPFS gets it’s name: **Inter-Planetary File System**! We’re striving to build a system that works across places as disconnected or far apart as other planets. That’s a pretty idealistic goal, but it keeps us working and thinking hard, and most everything we create in pursuit of that goal is also useful closer to home.


## Links don’t change on IPFS.

What about that link to the aardvark page above? It looked a little unusual:

```
/ipfs/QmXoypizjW3WknFiJnKLwHCnL72vedxjQkDDP1mXWo6uco/wiki/aardvark.html
```

That jumble of letters after `/ipfs/` is called a [*content identifier*]({{<relref "guides/concepts/cid.md">}}) and it’s how IPFS can get content from multiple places.

Traditional URLs and file paths such as…

- `https://en.wikipedia.org/wiki/aardvark`
- `/Users/Alice/Documents/term_paper.doc`
- `C:\Users\Joe\My Documents\project_sprint_presentation.ppt`

…identify a file by *where it’s located* — what computer it’s on and where on that computer’s hard drive it is. That doesn’t work if the file is in many places, though, like your neighbor’s computer and your friend’s across town.

Instead of being location-based, IPFS addresses a file by *what’s in it*, or by its *content*. The content identifier above is a *cryptographic hash* of the content at that address. The hash is unique to the content that it came from, even though it’s short (well, short compared to all the bits and bytes that make up the original content). It also allows you to verify that you got what you asked for — bad actors can’t just hand you content that doesn’t match. (If hashes are new to you, check out [the concept guide on hashes]({{<relref "guides/concepts/hashes.md">}}) for a good introduction.)

<aside class="alert alert-info">
  Why do we say “content” instead of “files” or “web pages” here? Because a content identifier can point to many different types of data, such as a single small file, a piece of a larger file, or metadata. (In case you don't know, metadata is “data about the data.” You use metadata when you access the date, location, or file size of your digital pictures, for example.) So, an individual IPFS address can refer to the metadata of just a single piece of a file, a whole file, a directory, a whole website, or any other kind of content. For more on this, check out the [_How IPFS Works_](/introduction/how-ipfs-works/) part of these docs!
</aside>
Because the address of a file in IPFS is created from the content itself, links in IPFS can’t be changed. For example…

- If the text on a web page is changed, the new version gets a new, different address.
- Content can’t be moved to a different address. On today's internet, a company could reorganize content on their website and move a page at `http://mycompany.com/what_we_do` to `http://mycompany.com/services`. In IPFS, the old link you have would still point to the same old content.

Of course, people want to update and change content all the time, and don't want to send new links every time they do it. This is entirely possible in an IPFS world, but explaining it requires a little more info than what's within the scope of this guide. Check out the concept guides on [IPNS]({{<relref "guides/concepts/ipns.md">}}) and the [Mutable File System (MFS)]({{<relref "guides/concepts/mfs.md">}}) to learn more about how changing content can work in a content-addressed, distributed system.

It’s important to remember in all of these situations using IPFS is participatory and collaborative. If nobody using IPFS has the content identified by a given address available for others to access, you won't be able to get it. On the other hand, content can’t be removed from IPFS as long as *someone* is interested enough to make it available, whether that person is the original author or not.


## It’s all about possession and participation.

While there's lots of complex technology in IPFS, the fundamental ideas are about changing how networks of people and computers communicate. Today’s World Wide Web is structured on *ownership* and *access*, meaning that you get files from whoever owns them — if they choose to grant you access. IPFS is based on the ideas of *possession* and *participation*, where many people have each others’ files and *participate* in making them available.

That means IPFS only works well when people are actively participating. If you use your computer to share files using IPFS, but then you turn your computer off, other people won't be able to get those files from you anymore. But if you or others make sure that copies of those files are stored on more than one computer that's powered on and running IPFS, those files will be more reliably available to other IPFS users who want them. This happens to some extent automatically: by default, your computer shares a file with others for a limited time after you've downloaded it using IPFS. You can also make content available more permanently by *pinning* it, which saves it to your computer and makes it available on your IPFS network until you decide to *unpin* it. (You can learn more about this in the [concept guide on pinning]({{<relref "guides/concepts/mfs.md">}})!)

If you want to make sure one of your own files is permanently shared on the internet today, you might use a for-pay file-sharing service like Dropbox. Some people have begun offering similar services based on IPFS called *pinning services*. But since IPFS makes this kind of sharing a built-in feature, you can also collaborate with friends or partner with institutions (for example, museums and libraries might work together) to share each others’ files. We hope IPFS can be the low-level tool that allows a rich fabric of communities, business, and cooperative organizations to all form a distributed web that is much more reliable, robust, and equitable than the one we have today.


## Next Steps

Sounds interesting? We’ll cover [how to use it]({{<relref "introduction/usage.md">}}) next.
