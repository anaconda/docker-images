# Dockerfile for container images that Anaconda, Inc. uses to build conda
# packages released on the "defaults" (repo.anaconda.com) channels.

FROM continuumio/anaconda-pkg-build:2023.03.28

RUN /opt/conda/bin/conda install --quiet --yes jcmorin-ana-org::anaconda-time-machine \
    && /opt/conda/bin/conda update --yes conda conda-build \
    && /opt/conda/bin/conda clean --index-cache --yes

ENV PATH="/opt/conda/bin:${PATH}"

CMD [ "/bin/bash" ]
