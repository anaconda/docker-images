FROM debian:7.4

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2
RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet http://repo.continuum.io/miniconda/Miniconda-3.8.0-Linux-x86_64.sh && \
    /bin/bash /Miniconda-3.8.0-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm Miniconda-3.8.0-Linux-x86_64.sh && \
    /opt/anaconda/bin/conda install --yes conda==3.8.0

ENV PATH /opt/anaconda/bin:$PATH
