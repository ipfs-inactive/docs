![IPFS Documentation](ipfs-docs-header.png "IPFS Documentation")

[![build status](https://img.shields.io/circleci/project/github/ipfs/docs/master.svg?style=flat-square)](https://circleci.com/gh/ipfs/docs)
[![](https://img.shields.io/badge/made%20by-Protocol%20Labs-blue.svg?style=flat-square)](https://protocol.ai/)
[![](https://img.shields.io/badge/project-IPFS-blue.svg?style=flat-square)](http://ipfs.io/)

## Join our weekly sync (all welcome!)
Mondays at 15:00-15:30 UTC / 4:00-4:30 pm BST / 7:00-7:30 am PST

📞 Zoom: https://protocol.zoom.us/j/568955431

 :orange_book: Notes from past calls can be found [here](https://www.google.com/url?q=https://docs.google.com/document/d/1EOD-pJi4GvRmGi9HHocgVV8uVHMFIZlyVgJDkvC3DQ4/edit&sa=D&ust=1563045367944000&usg=AOvVaw1PXuFUmNdcfz8M0oJjv1dP).
 
 🎬 Video recordings of past calls can be found in our [YouTube playlist](https://www.youtube.com/playlist?list=PLuhRWgmPaHtRnfsVYI2LbVS03BRX7TcXq).

## About this repo

This repo is used for two purposes:

1. To organize overall documentation work across the IPFS project
2. To host the documentation website for IPFS, available at https://docs.ipfs.io/

## IPFS docs: Q3 2019 Update

Based on feedback from the community via social media, forums, this repo, [IPFS Camp 2019](https://github.com/ipfs/camp/blob/master/DEEP_DIVES/30-ipfs-education-and-documentation.md), and a variety of other sources, we're placing increased emphasis on improvements to our overall documentation strategy (and its tactical implementation!) in Q3 2019.

IPFS documentation currently has a number of acute problems:

- There is **no clear introduction to the overall idea of what IPFS does, how it works or why it's useful** -- starting with "civilian" dweb basics and allowing users to dig deeper as they wish.
- IPFS has **lots of new concepts** that are just very different from the web technologies people know today; even if you're well versed in some of technologies central to IPFS, chances are good that you don't know them all, or understand right off the bat how they need to work together.
- **Developer docs are inconsistently located** and spread across a number of repos users have to hunt through.
- Clear, **standard API docs** are not always available.
- People are motivated to use IPFS for a variety of reasons, but **our docs don't yet offer clear goal-based pathways** for installing or learning more.
- In our open-source world, *how to use IPFS* is not always clearly differentiated from *how to contribute to IPFS*; **we need to offer materials targeted for both users and contributors of varying degrees of expertise** as IPFS expands in scale, scope and maturity.

We already have [some substantiative research](https://ipfs.io/ipfs/QmNj68gTzAs9QbfMKzMGurXP2WCmA6GTcKuUkWm4kBV1Qn/html/), including user interviews, that help us quantify the problems outlined above. In Q3 2019, we plan to use this body of knowledge, as well as additional work mentioned below, to formulate and begin execution upon an overall IPFS documentation approach that will benefit users in both the short and long term.

### Our Q3 2019 goals
*You can also view our progress against these in the [IPFS-wide OKR (Objectives and Key Results) tracking document](https://docs.google.com/spreadsheets/d/1AiNUL7vK5Jp8aa839UaMaI_AlBU5r6Bor-A40179I2A/edit#gid=1841105909), or [filter this repo's issues](https://github.com/ipfs/docs/labels/Priority%3A%20OKR) for ones with the `OKR` label.*

1. **Evaluate existing IPFS documentation content and presentation platform and make decisions for future-proof improvement and alignment**
- Complete a content audit of existing ipfs.io material and use to prioritize next steps		
- Create prioritized features list for a best-in-breed IPFS docs platform based on competitive-landscape and analogous product/service research, as well as community feedback
- Determine best-fit tech stack/framework for the IPFS docs site

2. **Better understand our users and their needs, and use this knowledge to prioritize improvements**	
- Complete the creation of ranked, goal-based personae for key IPFS user segments			
- Ensure appropriate resourcing in order to execute upon results of content audit, features list, user suggestion, or other asks

3. **Improve existing docs content in the short term, with emphasis on collecting metrics**
- Implement hotfixes for either content or metrics collection as they emerge from content audit, features list, or user suggestion
- Add interactive "so you'd like to ..." content on the front of ipfs.io (including analytics) with appropriate guidance for users' next steps
- [ProtoSchool](https://proto.school)-specific enhancements related to improved analytics and user feedback collection

### Q3 2019 goals team
- [@cwaring](https://github.com/cwaring)
- [@ericronne](https://github.com/ericronne)
- [@fsdiogo](https://github.com/fsdiogo)
- [@jessicaschilling](https://github.com/jessicaschilling)
- [@pkafei](https://github.com/pkafei)
- [@terichadbourne](https://github.com/terichadbourne)


## Want to get involved with IPFS documentation?

While we're making every effort to create a comprehensive plan for our overall documentation strategy in Q3 2019, that doesn't mean any pause in overall work in IPFS docs -- and to that end, we would love ❤️ **your** help with any of the types of content currently on the IPFS docs site:

1. **Introductory overview.** This lives in `content/introduction`. If you spot any problems, or have ideas for improvements, please post an [issue](https://github.com/ipfs/docs/issues) or PR. We're also in the midst of a [complete rework](https://github.com/ipfs/docs/pull/170) of the overall IPFS explainer, so please check its progress!

2. **Examples and tutorials.** At present, most examples currently live in other repos, like [js-ipfs examples](https://github.com/ipfs/js-ipfs/tree/master/examples). We're working on how to better integrate these, but if you have thoughts on how to best address this, please [file an issue here](https://github.com/ipfs/docs/issues). If you have feedback on an existing example, please file an issue or PR in that example's relevant repo. However, if you have ideas for new guides or tutorials, please [file an issue in this repo](https://github.com/ipfs/docs/issues)!

3. **Concept guides.** Concept guides (which live in the `content/guides/concepts` folder) are intended to present brief overviews of IPFS-related concepts that might be new to the average user. To see which concepts still need guides, please visit [this list](https://github.com/ipfs/docs/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen+concept+doc). All concept guides should focus on the following key points:

    1. **What** is this concept?
    2. How does it **relate** to the rest of IPFS?
    3. How can (or should?) you **use** it? 
    4. **Where** do you go to learn more?
    5. What is the **current state** of work on this concept?

4. **Reference/API Documentation.** Please see the [open issues in this repo](https://github.com/ipfs/docs/issues) for current activity around reference and API documentation.

5. **Community.** The Community section of [docs.ipfs.io](https://docs.ipfs.io/) is a work in progress, and we welcome ideas for how best to structure this information going forward! Please [file an issue in this repo](https://github.com/ipfs/docs/issues) with your thoughts.

6. **Any other issue in this repo with a ["help wanted"](https://github.com/ipfs/docs/labels/help%20wanted) label!**

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


## License

All software code is copyright (c) Protocol Labs, Inc. under the **MIT license**.

Other written documentation and content is copyright (c) Protocol Labs, Inc. under the [**Creative Commons Attribution-Share-Alike License**](https://creativecommons.org/licenses/by/4.0/).

See [LICENSE file](./LICENSE) for details.

