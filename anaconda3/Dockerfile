FROM debian:7.4

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet http://repo.continuum.io/anaconda3/Anaconda3-2.2.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda3-2.2.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda3-2.2.0-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.10.1

ENV PATH /opt/conda/bin:$PATH
