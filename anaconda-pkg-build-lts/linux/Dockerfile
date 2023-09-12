# Dockerfile for container images that Anaconda, Inc. uses to build conda
# packages released on the "defaults" (repo.anaconda.com) channels.

FROM continuumio/anaconda-pkg-build:latest

RUN  /opt/conda/bin/conda install --quiet --yes conda_time_machine
    

ENV PATH="/opt/conda/bin:${PATH}"

CMD [ "/bin/bash" ]
