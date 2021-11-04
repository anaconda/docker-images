# `Dockerfile`s for creating test images for QA to use.

Based on [anaconda-pkg-build](https://github.com/ContinuumIO/docker-images/blob/master/anaconda-pkg-build/linux/Dockerfile).

## Build examples

```
docker build -f ubuntu.Dockerfile -t anaconda-qa/ubuntu20 .
docker build -f clefos.Dockerfile -t anaconda-qa/clefos7 .
```

## Run examples

```
docker run -it --rm anaconda-qa/ubuntu20
docker run -it --rm anaconda-qa/clefos7
```