FROM ubuntu:14.04

MAINTAINER Travis Swicegood

RUN apt-get update && apt-get install -y wget bzip2
RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/conda.sh
RUN wget --quiet http://repo.continuum.io/miniconda/Miniconda-3.7.3-Linux-x86_64.sh
RUN /bin/bash /Miniconda-3.7.3-Linux-x86_64.sh -b -p /opt/anaconda
RUN rm Miniconda-3.7.3-Linux-x86_64.sh

ENV PATH /opt/anaconda/bin:$PATH
