FROM debian:jessie-slim
MAINTAINER Continuum Analytics, Inc. <conda@continuum.io>

RUN apt-get -qq update && apt-get -qq -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/archive/Anaconda3-4.3.1-Linux-x86_64.sh -o /tmp/anaconda.sh \
    && bash /tmp/anaconda.sh -bfp /usr/local \
    && rm -rf /tmp/anaconda.sh \
    && conda install -y python=3 conda=4.3.14 \
    && apt-get -qq -y autoremove \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/* /var/log/dpkg.log \
    && conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH
