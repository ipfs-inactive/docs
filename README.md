# IPFS Docs

This repo is used to:

1. Organize documentation work across the IPFS project
2. Host a documentation website for IPFS meant to replace what is currently at https://ipfs.io/docs

Read the Captain's Log or check the [issues](https://github.com/ipfs/docs/issues) for updates: [ipfs/docs#47](https://github.com/ipfs/docs/issues/47)


## Overview

IPFS documentation currently has several acute problems:

- There is **no clear introduction to the overall idea of exactly how IPFS works and what it’s doing.**
- IPFS has **lots of new concepts** (whether you are knowledgeable about things like graphs or not) that are just very different from the web technologies people know today.
- **Docs are inconsistently located** and spread across a number of repos people have to hunt through.
- Clear, **standard API docs** are not always available.
- **Hunting through GitHub is hard.** (Which repos have docs? Where in the repo are they? Which projects are important and how do they relate to the others? Which repos and docs are up-to-date?)

We aim to solve some of these problems through a documentation site (the source of which is in this repo) and others through organizing work, conventions, and practices across project repos (managed in the issues here).


## Contributing content

The documentation site contains several different kinds of content:

1. **Introductory overviews.** This lives in `content/introduction`. If you spot a problem or have improvements, please post an issue or PR. Please also take a look at [#60](https://github.com/ipfs/docs/issues/60) for planning and ongoing work in this area.

2. **Guides, examples, and tutorials.** Most examples currently live in other repos, like [js-ipfs examples](https://github.com/ipfs/js-ipfs/tree/master/examples). If you have thoughts on how to better integrate them, please file an issue here. If you have feedback on individual examples or want to add a new one, please file an issue or PR on the relevant repo. If you have ideas for guides or tutorials, they belong here! Please propose them in an issue here before creating a PR.

3. **Reference Documentation.** Please see the issues in this repo for current activity around reference/API documentation.

4. **Community.** If there are important missing community links, file an issue or PR here!

Before posting a PR with documentation changes, please also check [our styleguide](https://github.com/ipfs/community/blob/master/docs-styleguide.md).


## Developing the site

### One-Time Setup

1. [Install Hugo](https://gohugo.io/)
2. Install [AEgir](https://www.npmjs.com/package/aegir)

    ```sh
    npm install -g aegir
    ```

3. Download IPFS libraries and tools (e.g. go-ipfs, js-ipfs) and generate their documentation:

    ```sh
    make install
    ```

    This installs dependencies and generates source files from other projects (e.g. API documentation; theme resources from the `ipfs-css`, etc).

    When dependencies or external packages (like `go-ipfs`) have new releases, regenerate files based on them by running `make resources`.


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

Other written documentation and content (c) Protocol Labs, Inc. under the [**Creative Commons Attribution-Share-Alike License**](https://creativecommons.org/licenses/by/4.0/).

See [LICENSE file](./LICENSE) for details.
