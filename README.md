![IPFS Documentation](ipfs-docs-header.png "IPFS Documentation")

[![build status](https://img.shields.io/circleci/project/github/ipfs/docs/master.svg?style=flat-square)](https://circleci.com/gh/ipfs/docs)
[![](https://img.shields.io/badge/made%20by-Protocol%20Labs-blue.svg?style=flat-square)](https://protocol.ai/)
[![](https://img.shields.io/badge/project-IPFS-blue.svg?style=flat-square)](http://ipfs.io/)

## Join our weekly sync (all welcome!)
Tuesdays at 3:00pm UTC / 4:00pm BST / 7:00am PST

📞 Zoom: https://protocol.zoom.us/j/568955431

 :orange_book: Notes and recordings from previous sessions [can be found here](https://www.google.com/url?q=https://docs.google.com/document/d/1EOD-pJi4GvRmGi9HHocgVV8uVHMFIZlyVgJDkvC3DQ4/edit&sa=D&ust=1563045367944000&usg=AOvVaw1PXuFUmNdcfz8M0oJjv1dP)

## About this repo

This repo is used for two purposes:

1. To organize overall documentation work across the IPFS project
2. To host the documentation website for IPFS, available at https://docs.ipfs.io/

## IPFS docs: Q3 2019 Update

IPFS documentation currently has several acute problems:

- There is **no clear introduction to the overall idea of exactly how IPFS works and what it’s doing.**
- IPFS has **lots of new concepts** (whether you are knowledgeable about things like graphs or not) that are just very different from the web technologies people know today.
- **Docs are inconsistently located** and spread across a number of repos people have to hunt through.
- Clear, **standard API docs** are not always available.
- **Hunting through GitHub is hard.** (Which repos have docs? Where in the repo are they? Which projects are important and how do they relate to the others? Which repos and docs are up-to-date?)

We aim to solve some of these problems through a documentation site (the source of which is in this repo) and others through organizing work, conventions, and practices across project repos (managed in the issues here).

Check the near-term roadmap for this work in [issue #58](https://github.com/ipfs/docs/issues/58).

*Read a more detailed summary of our research on documentation problems in [issue #52](https://github.com/ipfs/docs/issues/52) or at [/ipfs/QmNj68gTzAs9QbfMKzMGurXP2WCmA6GTcKuUkWm4kBV1Qn/html](https://ipfs.io/ipfs/QmNj68gTzAs9QbfMKzMGurXP2WCmA6GTcKuUkWm4kBV1Qn/html/).*


## Want to get involved?

While we're making every effort to craft a comprehensive roadmap for our overall documentation strategy in Q3 2019, that doesn't mean any pause in overall work in IPFS docs -- and to that end, we would love ❤️ **your** help with any of the types of content currently on the IPFS docs site:

1. **Introductory overview.** This lives in `content/introduction`. If you spot any problems, or have ideas for improvements, please post an [issue](https://github.com/ipfs/docs/issues) or PR. We're also in the midst of a [complete rework](https://github.com/ipfs/docs/issues/60) of the overall IPFS explainer, so please check its progress!

2. **Examples and tutorials.** At present, most examples currently live in other repos, like [js-ipfs examples](https://github.com/ipfs/js-ipfs/tree/master/examples). We're working on how to better integrate these, but if you have thoughts on how to best address this, please [file an issue here](https://github.com/ipfs/docs/issues). If you have feedback on an existing example, please file an issue or PR in that example's relevant repo. However, if you have ideas for new guides or tutorials, please [file an issue in this repo](https://github.com/ipfs/docs/issues)!

3. **Concept guides.** Concept guides (which live in the `content/guides/concepts` folder) are intended to present brief overviews of IPFS-related concepts that might be new to the average user. To see which concepts still need guides, please visit [this checklist](https://github.com/ipfs/docs/issues/56). All concept guides should focus on the following key points:

    1. **What** is this concept?
    2. How does it **relate** to the rest of IPFS?
    3. How can (or should?) you **use** it? 
    4. **Where** do you go to learn more?
    5. What is the **current state** of work on this concept?

4. **Reference/API Documentation.** Please see the [open issues in this repo](https://github.com/ipfs/docs/issues) for current activity around reference and API documentation.

5. **Community.** The Community section of [docs.ipfs.io](https://docs.ipfs.io/) is a work in progress, and we welcome ideas for how best to structure this information going forward! Please [file an issue in this repo](https://github.com/ipfs/docs/issues) with your thoughts.

If you are able to contribute to any of the categories above, we thank you -- your work directly improves the future of IPFS for the global community! Before posting a PR with your changes, please be sure to check [our documentation style guide](https://github.com/ipfs/community/blob/master/DOCS_STYLEGUIDE.md) and the overall [IPFS contributor guidelines](https://github.com/ipfs/community/blob/master/CONTRIBUTING.md) so we can ensure that docs are clear, consistent, and simple to read. Finally, please make sure to follow the [IPFS code of conduct](https://github.com/ipfs/community/blob/master/code-of-conduct.md).

## Just want to build the docs site?

### One-time setup

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


### Build and run the site

* In the root directory, run `make dev`
* Load http://localhost:1313 in your web browser
* Edit and add things!

To create a production build, run `make build` instead. You’ll find the final static site in the `public` directory.


### Why is this is a static site?

We believe in hosting IPFS’s documentation on IPFS, and that’s much easier when the content is static.


### License

All software code is copyright (c) Protocol Labs, Inc. under the **MIT license**.

Other written documentation and content is copyright (c) Protocol Labs, Inc. under the [**Creative Commons Attribution-Share-Alike License**](https://creativecommons.org/licenses/by/4.0/).

See [LICENSE file](./LICENSE) for details.
