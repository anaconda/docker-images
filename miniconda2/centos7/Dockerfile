FROM centos:centos7
MAINTAINER Continuum Analytics, Inc. <conda@continuum.io>

RUN yum -y update \
    && yum -y install curl bzip2 \
    && curl -sSL https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o /tmp/miniconda.sh \
    && bash /tmp/miniconda.sh -bfp /usr/local/ \
    && rm -rf /tmp/miniconda.sh \
    && conda install -y python=2 conda=4.3.14 \
    && conda clean --all --yes \
    && rpm -e --nodeps bzip2 \
    && yum -y autoremove \
    && yum clean all
