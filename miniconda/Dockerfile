FROM debian:7.4

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2
RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/conda.sh
RUN wget --quiet http://repo.continuum.io/miniconda/Miniconda3-3.6.0-Linux-x86_64.sh && \
    /bin/bash /Miniconda3-3.6.0-Linux-x86_64.sh -b -p /opt/anaconda && \
    rm Miniconda3-3.6.0-Linux-x86_64.sh
