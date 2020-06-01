# THIS REPOSITORY IS BEING DEPRECATED

**Heads up! This repository has been deprecated and replaced with [`ipfs/ipfs-docs`](https://github.com/ipfs/ipfs-docs). This repository will not be receiving any updates. It is here for historical purposes.**

---

![IPFS Documentation](https://raw.githubusercontent.com/ipfs/docs/master/ipfs-docs-header.png "IPFS Documentation")
[![Build status icon.](https://img.shields.io/circleci/project/github/ipfs/docs/master.svg?style=flat-square)](https://circleci.com/gh/ipfs/docs)
[![Made by icon.](https://img.shields.io/badge/made%20by-Protocol%20Labs-blue.svg?style=flat-square)](https://protocol.ai/)
[![Project icon.](https://img.shields.io/badge/project-IPFS-blue.svg?style=flat-square)](http://ipfs.io/)

This repository organizes overall documentation issues across the IPFS project. It's also home to the codebase for the **legacy** IPFS documentation site (available at [docs.ipfs.io](https://docs.ipfs.io/)). **The code for the current (beta) version of IPFS documentation is available at [github.com/ipfs/ipfs-docs-v2](https://github.com/ipfs/ipfs-docs-v2), and all work on IPFS docs features OR content should be done there.** Once we fully deprecate the legacy site, we'll move the beta codebase into this repo.

- [Join our monthly sync](#join-our-monthly-sync)
- [Get involved](#get-involved)
- [Project organization](#project-organization)
  - [Objectives for 2020 Q1](#objectives-for-2020-q1)
  - [IPFS docs core members](#ipfs-docs-core-members)
- [Suggestions](#suggestions)
- [Bounties](#bounties)
- [Legacy code details](#legacy-code-details)
- [License](#license)

## Join our monthly sync

Every month the team gets together to discuss plans for the coming four-ish weeks. This meeting usually happens on the last Tuesday of each month. Feel free to [join us](https://protocol.zoom.us/j/614386160) using `614386160` as the Zoom meeting ID! Here are the details for the next meeting:

| Date | Time | Zoom ID | Link | Notes |
| ---- | ---- | ------- | ---- | ----- |
| Tuesday 26th May 2020 | UTC: 16:00 - 16:30<br>EST: 11:00 - 11:30<br>PST 08:00-08:30<br>Unix: 1590508800 | `92681067428` | [protocol.zoom.us/j/92681067428](https://protocol.zoom.us/j/92681067428) | [Meeting notes](https://www.google.com/url?q=https://docs.google.com/document/d/1EOD-pJi4GvRmGi9HHocgVV8uVHMFIZlyVgJDkvC3DQ4/edit&sa=D&ust=1563045367944000&usg=AOvVaw1PXuFUmNdcfz8M0oJjv1dP) |

If you can't make the meeting, don't worry. We post a recording of each meeting in our [YouTube playlist](https://www.youtube.com/playlist?list=PLuhRWgmPaHtRnfsVYI2LbVS03BRX7TcXq). Notes from current and past calls can be found [here](https://www.google.com/url?q=https://docs.google.com/document/d/1EOD-pJi4GvRmGi9HHocgVV8uVHMFIZlyVgJDkvC3DQ4/edit&sa=D&ust=1563045367944000&usg=AOvVaw1PXuFUmNdcfz8M0oJjv1dP).

## Get involved

We would **love ❤️ your help** to improve existing items or make new ones even better! [We also have bounties available!](https://github.com/ipfs/devgrants/projects/1) Here are some ideas to get you started:

1. **Join us on our weekly call!** See the top of this readme for full details on how and when.

2. **Claim an issue labeled "help wanted" in either [this docs repo](https://github.com/ipfs/docs/labels/help%20wanted) or [the IPFS website repo](https://github.com/ipfs/website/labels/help%20wanted)!** All our issues are T-shirt sized and roughly difficulty-graded (both using labels), so have a look for something that interests you in the time you have available, and dive on in! Leave your thoughts and questions in issue comments, and we'll get back to you as soon as possible.

3. **Create (or improve) an example, tutorial or concept guide!** At present, we have a variety of how-tos and concept guides available at [docs-beta.ipfs.io](https://docs-beta.ipfs.io). However, every new item we can offer makes it easier for the world's community to use and build on IPFS. If you'd like to write a new example/tutorial or concept guide, [take a look in our open issues](https://github.com/ipfs/docs/issues?q=is%3Aissue+is%3Aopen+label%3A%22Category%3A+Content%22) for items with the `Category: Content` label and see if any already-identified needs appeal to you. **Note that some issues may have bounties!** If you'd like to write something entirely new, feel free — PRs are welcome! Or, if you'd just like to improve existing docs content, feel free to fork it and add your suggestions.

4. **Help us improve how we present reference and API documentation.** In Q2 2020, we're investigating the best way to improve how we present reference materials like API documentation and command-line dictionaries. Got thoughts? [Please discuss them!](https://github.com/ipfs/docs/issues/393)

If you're able to contribute to any of the categories above, we thank you in advance -- your work directly improves the future of IPFS for the global community! Before posting a PR with your changes, please be sure to check [our documentation style guide](https://github.com/ipfs/community/blob/master/DOCS_STYLEGUIDE.md) and the overall [IPFS contributor guidelines](https://github.com/ipfs/community/blob/master/CONTRIBUTING.md) so we can ensure that docs are clear, consistent, and simple to read. Finally, please make sure to follow the [IPFS code of conduct](https://github.com/ipfs/community/blob/master/code-of-conduct.md).

### Issues

If you find something wrong within this repository, please raise an [issue here](https://github.com/ipfs/docs/issues).

#### IPFS Docs beta

Issues regarding the new IPFS Docs beta website should be raised in [this repository's issue tracker](https://github.com/ipfs/docs/issues). The **Issues** tab has been disabled in the `ipfs/ipfs-docs-v2` repository to stop issues being posted there. The content of `ipfs/ipfs-docs-v2` will be merged with the content of this repository in quarter 2 of 2020. We could completely delete the `ipfs/docs` repository and replace it with `ipfs/ipfs-docs-v2`. However, we still want to be able to view the git commit history and issues previously raised within this repository.

## Project organization

### Objectives for 2020 Q1

Here's a summary of this our objectives for the first three months of 2020:

1. ✅ Launch the [beta IPFS documentation](https://docs-beta.ipfs.io/) site on the IPFS network.
2. Improve documentation by creating new and/or enhancing existing content based on [issues in this repo](https://github.com/ipfs/docs/issues).
3. Resolving or addressing any new GitHub issues created in this repo this quarter.
4. Setting up and enabling a community of writers and content creators.

For more information regarding these objectives, check out the [IPFS-wide Objectives and Key Results (OKRs) tracking document](https://docs.google.com/spreadsheets/d/1vOSCIufWfU2CpG63rOTGVQ6tWNYcbnYvR2k_kN84jQU/edit#gid=1562851442).

## Suggestions

Do you have suggestions on future improvements to IPFS docs? You can [vote](https://ipfs.canny.io/docs-features) on what you think the IPFS docs site should contain, along with features that you'd like to see over at [canny.io/docs-features](https://ipfs.canny.io/docs-features).

### IPFS docs core members

- [@johnnymatthews](https://github.com/johnnymatthews): Project leadership, organization and primary contact
- [@cwaring](https://github.com/cwaring): Development support

## Bounties

You can earn the undying love of the IPFS community *and* make some money by closing an issue with the [`bounty` tag](https://github.com/ipfs/docs/issues?q=is%3Aopen+is%3Aissue+label%3Abounty)! Submissions must be production-ready and meet all the specifications listed on the issue page. Check out the [current list of open bounties →](https://github.com/ipfs/devgrants/projects/1)

## Legacy code details

**IMPORTANT! As noted above, this repo is home to the LEGACY docs site; if you want to make changes to IPFS docs, please visit [github.com/ipfs/ipfs-docs-v2](https://github.com/ipfs/ipfs-docs-v2) and use the codebase there.** However, if for some reason you need to run the legacy code locally, instructions are below.

### One-time setup

1. Install [AEgir](https://www.npmjs.com/package/aegir)

    ```sh
    npm install -g aegir
    ```

2. Download dependencies and IPFS libraries (e.g., go-ipfs, js-ipfs) and generate their documentation:

    ```sh
    make install
    ```

 This installs dependencies and generates source files from other projects (e.g., API documentation, theme resources from the `ipfs-css`, etc). When dependencies or external packages (like `go-ipfs`) have new releases, you should regenerate files based on them by running `make resources`.

### Build and run

1. In the root directory, run `make dev`.
2. Load [localhost:1313](http://localhost:1313) in your web browser.
3. Edit and add things!

To create a production build, run `make build` instead. You'll find the final static site in the `public` directory.

## License

All software code is copyright (c) Protocol Labs, Inc. under the **MIT license**. Other written documentation and content is copyright (c) Protocol Labs, Inc. under the [**Creative Commons Attribution-Share-Alike License**](https://creativecommons.org/licenses/by/4.0/). See [LICENSE file](./LICENSE) for details.
