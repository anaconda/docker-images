FROM debian:7.4

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet http://repo.continuum.io/archive/Anaconda-2.1.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda-2.1.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda-2.1.0-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.8.0

ENV PATH /opt/conda/bin:$PATH
