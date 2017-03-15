FROM centos:centos5
MAINTAINER Continuum Analytics, Inc. <conda@continuum.io>

RUN yum -y update; yum clean all \
    && yum -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=3 conda=4.3.14\
    && conda clean --all --yes

ENV PATH /opt/conda/bin:$PATH
