# IPFS Documentation

[![Build status icon.](https://img.shields.io/circleci/project/github/ipfs/docs/master.svg?style=flat-square)](https://circleci.com/gh/ipfs/docs)
[![Made by icon.](https://img.shields.io/badge/made%20by-Protocol%20Labs-blue.svg?style=flat-square)](https://protocol.ai/)
[![Project icon.](https://img.shields.io/badge/project-IPFS-blue.svg?style=flat-square)](http://ipfs.io/)

This repo is used for two purposes:

1. To organize overall documentation work across the IPFS project, as managed by the **IPFS Documentation** working group.
2. To host the documentation website for IPFS at [docs.ipfs.io](https://docs.ipfs.io/).

## Join our weekly sync

Every Monday the team gets together to discuss our plans for the coming week. Feel free to [join us](https://protocol.zoom.us/j/614386160) using `614386160` as the Zoom meeting ID!

| UTC | Eastern Standard Time (EST) | Pacific Standard Time (PST)|
| --- | --- | --- |
| 16:00-16:30 | 11:00 - 11:30 | 08:00 - 08:30 |

If you can't make the meeting, don't worry. We post a recording of each meeting in our [YouTube playlist](https://www.youtube.com/playlist?list=PLuhRWgmPaHtRnfsVYI2LbVS03BRX7TcXq).

Notes from current and past calls can be found [here](https://www.google.com/url?q=https://docs.google.com/document/d/1EOD-pJi4GvRmGi9HHocgVV8uVHMFIZlyVgJDkvC3DQ4/edit&sa=D&ust=1563045367944000&usg=AOvVaw1PXuFUmNdcfz8M0oJjv1dP).

## Objectives for 2020 Q1

Here's a summary of this our objectives for the first three months of 2020:

1. Launch the [beta IPFS documentation](https://docs-beta.ipfs.io/) site on the IPFS network.
2. Improve documentation by:
   1. Creating new content based on [existing issues](https://github.com/ipfs/docs/issues).
   2. Improve and update existing pages.
3. Resolve or address new GitHub issues created this quarter.
4. Set up a community of writers and content creators.

For more information regarding these objectives, check out the [IPFS-wide objectives and key-results tracking document](https://docs.google.com/spreadsheets/d/1VeyiLvBdX_PrP394kU_lwkQZxfNwqMVX1f7K4ursSPM/edit#gid=1841105909).

## IPFS docs core members for this quarter

- [@terichadbourne](https://github.com/terichadbourne)
- [@johnnymatthews](https://github.com/johnnymatthews)
- [@jessicaschilling](https://github.com/jessicaschilling)
- [@cwaring](https://github.com/cwaring)

## Suggestions for the docs

You can [vote](https://ipfs.canny.io/docs-features) on what you think the IPFS docs site should contain, along with features that you'd like to see over at [canny.io/docsd-features](https://ipfs.canny.io/docs-features).

## Get involved

We would **love ❤️ your help** to improve existing items or make new ones even better! Here are some ideas to get you started:

1. **Join us on our weekly call!** See the top of this readme for full details on how and when.

2. **Claim an issue labeled "help wanted" in either [this docs repo](https://github.com/ipfs/docs/labels/help%20wanted) or [the IPFS website repo](https://github.com/ipfs/website/labels/help%20wanted)!** All our issues are T-shirt sized and roughly difficulty-graded (both using labels), so have a look for something that interests you in the time you have available, and dive on in! Leave your thoughts and questions in issue comments, and we'll get back to you as soon as possible.

3. **Create (or improve) an example, tutorial or concept guide!** At present, we have a variety of how-tos and concept guides either living in this docs repo, or linked to from the nav menu at [docs.ipfs.io](https://docs.ipfs.io). However, every new item we can offer makes it easier for the world's community to use and build on IPFS. If you'd like to write a new example/tutorial or concept guide, [take a look in our open issues](https://github.com/ipfs/docs/issues?q=is%3Aissue+is%3Aopen+label%3A%22OKR%3A+Content+Improvement%22) for items with the `OKR: Content Improvement` label and see if any already-identified needs appeal to you. If you'd like to write something entirely new, feel free — PRs are welcome! Or, if you'd just like to improve existing docs content, feel free to fork it and add your suggestions.

4. **Help us improve how we present reference and API documentation.** In Q1 2020, we're investigating the best way to improve how we present reference materials like API documentation and command-line dictionaries. Got thoughts? [Please discuss them!](https://github.com/ipfs/docs/issues/393)

If you're able to contribute to any of the categories above, we thank you in advance -- your work directly improves the future of IPFS for the global community! Before posting a PR with your changes, please be sure to check [our documentation style guide](https://github.com/ipfs/community/blob/master/DOCS_STYLEGUIDE.md) and the overall [IPFS contributor guidelines](https://github.com/ipfs/community/blob/master/CONTRIBUTING.md) so we can ensure that docs are clear, consistent, and simple to read. Finally, please make sure to follow the [IPFS code of conduct](https://github.com/ipfs/community/blob/master/code-of-conduct.md).

## Run the docs locally

If you want to spin up a local version of the docs site, follow these steps:

### One-time setup

1. Install [AEgir](https://www.npmjs.com/package/aegir)

    ```sh
    npm install -g aegir
    ```

2. Download dependencies and IPFS libraries (e.g. go-ipfs, js-ipfs) and generate their documentation:

    ```sh
    make install
    ```

    This installs dependencies and generates source files from other projects (e.g. API documentation; theme resources from the `ipfs-css`, etc). When dependencies or external packages (like `go-ipfs`) have new releases, you should regenerate files based on them by running `make resources`.

### Build and run the site

1. In the root directory, run `make dev`.
2. Load [localhost:1313](http://localhost:1313) in your web browser.
3. Edit and add things!

To create a production build, run `make build` instead. You’ll find the final static site in the `public` directory.

## License

All software code is copyright (c) Protocol Labs, Inc. under the **MIT license**. Other written documentation and content is copyright (c) Protocol Labs, Inc. under the [**Creative Commons Attribution-Share-Alike License**](https://creativecommons.org/licenses/by/4.0/). See [LICENSE file](./LICENSE) for details.
