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

## Automatic updates using renovate

### Preparing `Dockerfile`s for updates

Docker images using the Miniconda or Anaconda Distribution installers can be updated using `renovate`.
To achieve this, the `Dockerfile` must have the following lines:

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

### Understanding the transform templates

Since the installers are updated in a format that is not covered using pre-existing `renovate` managers, a [custom datasource](https://docs.renovatebot.com/modules/datasource/custom/) had to be created.
It uses a transform template to convert the `.files.json` file into a format `renovate` can process.
Unfortunately, `renovate` expects a an array of objects whereas the `.files.json` file is a nested object.
The file needs to be processed using [JSONata](https://jsonata.org/) and stored as `transformTemplates`.

Pretty-printed, the template for is the following for Miniconda:

```
{
    "releases": [
        $map($sift($, function($v, $k) {
            $not($k.$contains("latest"))
            and $v.sha256 = $lookup($, "Miniconda3-latest-{{ packageName }}").sha256
        }).$keys(), function($v) {
            {
                "digest": $lookup($, $v).sha256, "version": $contains($v.$split("-")[2], /^[0-9]+$/) ? $v.$split("-")[1] & "-" & $v.$split("-")[2] : $v.$split("-")[1],
                "changeLogUrl": "https://docs.anaconda.com/free/miniconda/miniconda-release-notes/#miniconda-" & ($contains( $v.$split("-")[2], /^[0-9]+$/) ? $v.$split("-")[1].$split("_")[1] & "-" & $v.$split("-")[2] : $v.$split("-")[1].$split("_")[1]).$replace(".", "-"),

                "sourceUrl": "https://repo.anaconda.com/miniconda/" & $v, releaseTimestamp": $fromMillis($lookup($, $v).mtime * 1000, "[Y0001]-[M01]-[D01]T[H01]:[m01]", "-6")
            }
        }
    )],
    "sourceUrl": "https://repo.anaconda.com/miniconda/",
    "homepage": "https://anaconda.com"
}
```

and the following for Anaconda Distribution:

```
{
    "releases": $map(
        $sift($, function($v, $k){
            $k.$contains("{{ packageName }}")
        }).$keys(), function($v) {
            {
                "digest": $lookup($, $v).sha256,
                "version": $contains($v.$split("-")[2], /^[0-9]+$/) ? $v.$split("-")[1] & "-" & $v.$split("-")[2] : $v.$split("-")[1],
                "changeLogUrl": "https://docs.anaconda.com/free/anaconda/release-notes/#anaconda-" & ($contains( $v.$split("-")[2], /^[0-9]+$/) ? $v.$split("-")[1] & "-" & $v.$split("-")[2] : $v.$split("-")[1]).$replace(".", "-"),
                "sourceUrl": "https://repo.anaconda.com/archive/" & $v,
                "releaseTimestamp": $fromMillis($lookup($, $v).mtime * 1000, "[Y0001]-[M01]-[D01]T[H01]:[m01]", "-6")
            }
        }
    ),
    "sourceUrl": "https://repo.anaconda.com/archive/",
    "homepage": "https://anaconda.com"
}
```

The `$map` function creates an array of releases containing data such as the version, the digest (the sha256 sum), changelog URL, etc.
The `$sift` function is used to filter the appropriate installer file names that are passed into `$map`.

All `$sift` functions make use of the `{{ packageName}}` template value.
`packageName` corresponds to `depName` in the regular expressions of the `matchStrings` (`depName` cannot be used in the JSONata because renovate only replaces [a few variables](https://docs.renovatebot.com/modules/datasource/custom/#usage)).
The value of `depName` and `packageName` is the installler suffix (e.g., `Linux-x86_64.sh`)
to capture and group installer types.
Overloading `depName` and `packageName` this way has the drawback that by default `renovate` would create a pull request for each architecture.
To override this behavior, the `packageRules` bundle all Miniconda/Anaconda Distribution updates into a single PR each.

Since Miniconda has multiple installer variants and also a set of "latest" installers, the logic is more complex.
The `$sift` condition only grabs the installer that is identical to the "latest" installer, i.e., `releases` will only contain the latest installer.
JSONata flattens arrays with only one element, which is why `[]` is wrapped around the `$map` function for Miniconda, but not for Anaconda Distribution.

The version string uses a ternary operator to account for the build number, which not all installers have.
The same pattern is used in `changeLogUrl`, but `.` needs to be replaced with `-` to get the appropriate anchor. For Miniconda, the extra `$split` filters out the `py*_` prefix in the version.

The timestamp is given in Central Standard Time, which is used for release dates in documentation.
The format specifier follows the [XPATH F&O 3.1](https://www.w3.org/TR/xpath-functions-31/#date-picture-string) specification, as required by JSONata.

The transform template currently produces more data than needed because it is expected to become global once it is fully tested.
