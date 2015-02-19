FROM debian:7.4

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet http://repo.continuum.io/miniconda/Miniconda3-3.8.3-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-3.8.3-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda3-3.8.3-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.8.3

ENV PATH /opt/conda/bin:$PATH
