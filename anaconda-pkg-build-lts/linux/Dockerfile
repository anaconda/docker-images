# Dockerfile for container images that Anaconda, Inc. uses to build conda
# packages released on the "defaults" (repo.anaconda.com) channels.

FROM continuumio/anaconda-pkg-build:2023.03.28

RUN  /opt/conda/bin/conda install -c jcmorin-ana-org --quiet --yes anaconda-time-machine


ENV PATH="/opt/conda/bin:${PATH}"

CMD [ "/bin/bash" ]
