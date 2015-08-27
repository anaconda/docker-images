FROM debian:7.4

MAINTAINER Kamil Kwiek <kamil.kwiek@continuum.io>

RUN apt-get update && apt-get install -y wget bzip2 ca-certificates \
    libglib2.0-0 libxext6 libsm6 libxrender1
RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    wget --quiet https://repo.continuum.io/archive/Anaconda-2.3.0-Linux-x86_64.sh && \
    /bin/bash /Anaconda-2.3.0-Linux-x86_64.sh -b -p /opt/conda && \
    rm /Anaconda-2.3.0-Linux-x86_64.sh && \
    /opt/conda/bin/conda install --yes conda==3.14.1

ENV PATH /opt/conda/bin:$PATH

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8