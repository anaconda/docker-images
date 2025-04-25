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
[anaconda3](https://hub.docker.com/r/continuumio/anaconda3)    | Container with a bootstrapped Anaconda installation  | [![](https://img.shields.io/docker/v/continuumio/anaconda3/latest?label=version)](https://hub.docker.com/r/continuumio/anaconda3)   | [![](https://img.shields.io/docker/pulls/continuumio/anaconda3)](https://hub.docker.com/r/continuumio/anaconda3)   | [![](https://img.shields.io/docker/stars/continuumio/anaconda3)](https://hub.docker.com/r/continuumio/anaconda3)
[miniconda3](https://hub.docker.com/r/continuumio/miniconda3)  | Container with a bootstrapped Miniconda installation | [![](https://img.shields.io/docker/v/continuumio/miniconda3/latest?label=version)](https://hub.docker.com/r/continuumio/miniconda3) | [![](https://img.shields.io/docker/pulls/continuumio/miniconda3)](https://hub.docker.com/r/continuumio/miniconda3) | [![](https://img.shields.io/docker/stars/continuumio/miniconda3)](https://hub.docker.com/r/continuumio/miniconda3)
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

## Automatic updates using renovate

Docker images using the Miniconda or Anaconda Distribution installers can be updated using `renovate`.

### Updates with sha256 checks

To update Dockerfiles that contain sha256 checks, the full URL and sha256 sums need to be provided for each installer:

```
# renovate datasource=custom.miniconda
ARG INSTALLER_URL="<URL to installer file>"
ARG SHA256SUM="<installer checksum>"
```

The sha variable must be in the line beneath the installer URL.
For Anaconda Distribution, the `datasource` must be changed to `custom.anaconda`.

The variable names can have suffixes if there are multiple installers in one file, for example:
```
# renovate datasource=custom.miniconda
ARG INSTALLER_URL_LINUX64="<URL to linux-64 installer file>"
ARG SHA256SUM_LINUX64="<linux-64 installer checksum>"
# renovate datasource=custom.miniconda
ARG INSTALLER_URL_AARCH64="<URL to linux-aarch64 installer file>"
ARG SHA256SUM_AARCH64="<linux-aarch64 installer checksum>"
```

### Simple version number updates

If not checksums are needed, the Dockerfile can be simplified:

```
# renovate: datasource=custom.miniconda depName=Linux-x86_64.sh
ARG INSTALLER_VERSION=<installer version>
```

`Linux-x86_64.sh` can be replaced by any installer suffix supported in the latest release.
