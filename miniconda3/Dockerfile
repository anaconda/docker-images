FROM debian:7.4

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates libglib2.0-0
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/miniconda/Miniconda3-3.9.1-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-3.9.1-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-3.9.1-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.10.1

ENV PATH /opt/conda/bin:$PATH
