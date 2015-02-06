FROM ubuntu:14.04

MAINTAINER Travis Swicegood

RUN apt-get update
RUN apt-get install -y wget bzip2
RUN echo 'export PATH=/opt/anaconda/bin:$PATH' > /etc/profile.d/conda.sh
RUN wget --quiet http://repo.continuum.io/archive/Anaconda-2.1.0-Linux-x86_64.sh -O /Anaconda-2.1.0-Linux-x86_64.sh
RUN /bin/bash /Anaconda-2.1.0-Linux-x86_64.sh -b -p /opt/anaconda
RUN rm /Anaconda-2.1.0-Linux-x86_64.sh

