FROM centos:centos7
MAINTAINER Continuum Analytics, Inc. <conda@continuum.io>

RUN yum -y update; yum clean all \
    && yum -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/archive/Anaconda2-4.3.1-Linux-x86_64.sh -o /tmp/anaconda.sh \
    && bash /tmp/anaconda.sh -bfp /usr/local \
    && rm -rf /tmp/anaconda.sh \
    && conda install -y python=2 conda=4.3.14\
    && conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH
