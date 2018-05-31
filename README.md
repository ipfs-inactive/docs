# IPFS Docs

> Documentation website for the IPFS project

For now: ipns://beta.docs.ipfs.io and https://beta.docs.ipfs.io

Read the Captain's Log for updates: [ipfs/docs#47](https://github.com/ipfs/docs/issues/47)

- Overview
- Contributing content
- Developing the site
- Automatic builds
- FAQ
  - Why is it critical this is a static site?
- License


## Overview

TODO


## Contributing content

TODO


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

### Why is it critical this is a static site?

TODO


## License

All software code is copyright (c) Protocol Labs, Inc. under the **MIT license**.

Other written documentation and content (c) Protocol Labs, Inc. under the [**Creative Commons Attribution-Share-Alike License**](https://creativecommons.org/licenses/by/4.0/).

See [LICENSE file](./LICENSE) for details.
