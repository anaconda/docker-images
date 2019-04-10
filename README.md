# Anaconda and Miniconda Docker Docker Docker

Docker images for Anaconda/Miniconda that are available from Docker Hub:

https://hub.docker.com/r/continuumio/

Documentation for Anaconda Integrations, including Docker:

https://docs.anaconda.com/anaconda/user-guide/tasks/docker/

Push All:

```
docker push continuumio/anaconda:latest
docker push continuumio/anaconda:5.2.0
docker push continuumio/anaconda2:latest
docker push continuumio/anaconda2:5.2.0
docker push continuumio/anaconda3:latest
docker push continuumio/anaconda3:5.2.0
docker push continuumio/miniconda:latest
docker push continuumio/miniconda:4.5.4
docker push continuumio/miniconda2:latest
docker push continuumio/miniconda2:4.5.4
docker push continuumio/miniconda3:latest
docker push continuumio/miniconda3:4.5.4
```

## How to build anaconda images

1. Update the version in `anaconda/**/Dockerfile` and `anaconda3/**/Dockerfile`
2. cd to scripts
3. bash build_anaconda.sh -v <version>
4. push all the things
