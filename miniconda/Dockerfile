FROM debian:7.4

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda-3.9.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda-3.9.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda-3.9.1-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.10.1

ENV PATH /opt/conda/bin:$PATH
