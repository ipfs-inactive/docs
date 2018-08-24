# IPFS Docs

This repo is used to:

1. Organize documentation work across the IPFS project.
2. Host the documentation website for IPFS. It gets published to https://docs.ipfs.io/.

Read the Captain's Log or check the [issues](https://github.com/ipfs/docs/issues) for updates: [ipfs/docs#47](https://github.com/ipfs/docs/issues/47)


## Overview

IPFS documentation currently has several acute problems:

- There is **no clear introduction to the overall idea of exactly how IPFS works and what it’s doing.**
- IPFS has **lots of new concepts** (whether you are knowledgeable about things like graphs or not) that are just very different from the web technologies people know today.
- **Docs are inconsistently located** and spread across a number of repos people have to hunt through.
- Clear, **standard API docs** are not always available.
- **Hunting through GitHub is hard.** (Which repos have docs? Where in the repo are they? Which projects are important and how do they relate to the others? Which repos and docs are up-to-date?)

We aim to solve some of these problems through a documentation site (the source of which is in this repo) and others through organizing work, conventions, and practices across project repos (managed in the issues here).

Check the near-term roadmap for this work in [issue #58](https://github.com/ipfs/docs/issues/58).

*Read a more detailed summary of our research on documentation problems in [issue #52](https://github.com/ipfs/docs/issues/52) or at [/ipfs/QmNj68gTzAs9QbfMKzMGurXP2WCmA6GTcKuUkWm4kBV1Qn/html](https://ipfs.io/ipfs/QmNj68gTzAs9QbfMKzMGurXP2WCmA6GTcKuUkWm4kBV1Qn/html/).*


## Contributing content

The documentation site contains several different kinds of content. We’d love ❤️ **your** help with any of it:

1. **Introductory overviews.** This lives in `content/introduction`. If you spot a problem or have improvements, please post an issue or PR. Please also take a look at [#60](https://github.com/ipfs/docs/issues/60) for planning and ongoing work in this area.

2. **Guides, examples, and tutorials.** Most examples currently live in other repos, like [js-ipfs examples](https://github.com/ipfs/js-ipfs/tree/master/examples). If you have thoughts on how to better integrate them, please file an issue here. If you have feedback on individual examples or want to add a new one, please file an issue or PR on the relevant repo. If you have ideas for guides or tutorials, they belong here! Please propose them in an issue here before creating a PR.

3. **Concept guides.** These are a special category in the *guides* section listed above. Concept guides are intended to present a brief overview IPFS-related concepts that might be new to people. They live in the `content/guides/concepts` folder and should strive to answer:

    1. **What** is this?
    2. How does it **relate** to the rest of IPFS?
    3. How can (or should?) you **use** it? (Note: sometimes the answer is that you should understand it, but *not* use it. *Bitswap* is probably a good example.)
    4. **Where** do you go to learn more?
    5. What is the **current state** of affairs?

    See a list of concepts we need help with by [checking the issues](https://github.com/ipfs/docs/issues?utf8=✓&q=is%3Aissue+is%3Aopen+label%3Acontent+concept) or reading through [issue #56](https://github.com/ipfs/docs/issues/56)

4. **Reference Documentation.** Please see the issues in this repo for current activity around reference/API documentation.

5. **Community.** If there are important missing community links, file an issue or PR here!

This repo is also a website, which means we could also use your help with design and technical features (interactive examples, better syntax highlighting, scripts to pull in content from other repos, etc.) in addition to writing. To get a sense of what we could use help on, check the [the issues](https://github.com/ipfs/docs/issues). If you decide to work on one, please post to the issue to let us know!

Before posting a PR with your changes, please check [our styleguide](https://github.com/ipfs/community/blob/master/DOCS_STYLEGUIDE.md) and [contributing guide](https://github.com/ipfs/community/blob/master/contributing.md).

Finally, let’s work together to keep this a respectful and friendly space. Please make sure to follow [our code of conduct](https://github.com/ipfs/community/blob/master/code-of-conduct.md).

[![](https://cdn.rawgit.com/jbenet/contribute-ipfs-gif/master/img/contribute.gif)](https://github.com/ipfs/community/blob/master/contributing.md)


## Building the Docs Site

### One-Time Setup

1. Install [AEgir](https://www.npmjs.com/package/aegir)

    ```sh
    npm install -g aegir
    ```

2. Download dependencies and IPFS libraries (e.g. go-ipfs, js-ipfs) and generate their documentation:

    ```sh
    make install
    ```

    This installs dependencies and generates source files from other projects (e.g. API documentation; theme resources from the `ipfs-css`, etc).

    When dependencies or external packages (like `go-ipfs`) have new releases, you should regenerate files based on them by running `make resources`.


### Build and Run the Site

* In the root directory, run `make dev`
* Load http://localhost:1313 in your web browser
* Edit and add things!

To create a production build, run `make build` instead. You’ll find the final static site in the `public` directory.


## FAQ

### Why is this is a static site?

We believe in hosting IPFS’s documentation on IPFS, and that’s much easier when the content is static.


## License

All software code is copyright (c) Protocol Labs, Inc. under the **MIT license**.

Other written documentation and content is copyright (c) Protocol Labs, Inc. under the [**Creative Commons Attribution-Share-Alike License**](https://creativecommons.org/licenses/by/4.0/).

See [LICENSE file](./LICENSE) for details.
