[![Conventional Commits](https://img.shields.io/badge/Conventional%20Commits-1.0.0-yellow.svg)](https://conventionalcommits.org)

# Docker Compose

This is an opinionated image that's used for tooling.
It's currently only used in a CI environment.

# How to use this

The image comes with a Makefile that has everything abstracted away for you to easily customize it.

```bash
$ make DOCKER_VERSION=19.03.2 DOCKER_COMPOSE_VERSION=1.24.1 build push

```

## Available VARS

```bash
DOCKER_VERSION=18.09.9
DOCKER_COMPOSE_VERSION=1.24.1
TAG_COMPOSE=d-${DOCKER_VERSION}-dc-${COMPOSE_VERSION}
REGISTRY=${REGISTRY:-ORGANIZATION/docker-compose}
VCS_URL=${VCS_URL:-https://THE_REPO_URL}
```

## Optional Setup

If you are into some tooling for keeping commit-messages clean and want to keep an automated CHANGELOG.md, feel free to `make init` ;).

It'll install the node_modules:
- standard-version,
- husky
- commit-lint

To make this work you need to have NODE.js installed.

# Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style.

1. Fork it
2. Create your feature branch (git checkout -b feature/my-cool-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin feature/my-new-feature)
5. Create new Pull Request

# License
Copyright (c) 2020 Territory Embrace - Talent Platforms.
