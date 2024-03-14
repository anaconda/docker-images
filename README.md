# Anaconda and Miniconda Docker Images and Documentation

Docker images for Anaconda/Miniconda that are available from DockerHub:

https://hub.docker.com/r/continuumio/

Documentation for Anaconda Integrations, including Docker:

https://docs.anaconda.com/anaconda/user-guide/tasks/docker/

Package build images hosted on ECR can be found here:

https://gallery.ecr.aws/y0o4y9o3/anaconda-pkg-build

Package build images hosted on DockerHub can be found here:

https://hub.docker.com/r/continuumio/anaconda-pkg-build/tags?page=1&ordering=last_updated


image            | description                               | version | pulls | stars
---------------- | ----------------------------------------- | ------- | ----- | -----
[anaconda3](https://hub.docker.com/r/continuumio/anaconda3)    | Container with a bootstrapped Anaconda installation  | [![](https://img.shields.io/docker/v/continuumio/anaconda3?sort=semver)](https://hub.docker.com/r/continuumio/anaconda3)   | [![](https://img.shields.io/docker/pulls/continuumio/anaconda3)](https://hub.docker.com/r/continuumio/anaconda3)   | [![](https://img.shields.io/docker/stars/continuumio/anaconda3)](https://hub.docker.com/r/continuumio/anaconda3)
[miniconda3](https://hub.docker.com/r/continuumio/miniconda3)  | Container with a bootstrapped Miniconda installation | [![](https://img.shields.io/docker/v/continuumio/miniconda3?sort=semver)](https://hub.docker.com/r/continuumio/miniconda3) | [![](https://img.shields.io/docker/pulls/continuumio/miniconda3)](https://hub.docker.com/r/continuumio/miniconda3) | [![](https://img.shields.io/docker/stars/continuumio/miniconda3)](https://hub.docker.com/r/continuumio/miniconda3)
[Anaconda Package Build](https://hub.docker.com/r/continuumio/anaconda-pkg-build/tags?page=1&ordering=last_updated)  | Container with a bootstrapped Anaconda installation with GCC | [![](https://img.shields.io/docker/v/continuumio/anaconda-pkg-build?sort=semver)](https://hub.docker.com/r/continuumio/anaconda-pkg-build) | [![](https://img.shields.io/docker/pulls/continuumio/anaconda-pkg-build)](https://hub.docker.com/r/continuumio/anaconda-pkg-build) | [![](https://img.shields.io/docker/stars/continuumio/anaconda-pkg-build)](https://hub.docker.com/r/continuumio/anaconda-pkg-build)

## Updating and publishing Docker images

Docker images are updated by changing the appropriate `Dockerfile`s in each subdirectory.
For Miniconda (`miniconda3`) and Anaconda Distribution (`anaconda3`) this is automatically done by `renovate`.

To publish a Docker image, a release has to be created.
The scheme for the release tag name is specified in each workflow file, for example:

```
on:
  push:
    branches:
      - main
    tags:
      - 'anaconda3-*'
```

If an image with the same version needs to be republished, the version number should be amended with `.postN` where `N` is an integer.
