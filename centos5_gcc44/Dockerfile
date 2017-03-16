FROM centos:5.11
MAINTAINER Continuum Analytics, Inc. <conda@continuum.io>

ENV container docker
WORKDIR /build_scripts
COPY install_yum_deps.sh symlink_libraries.sh /build_scripts/
RUN yum -y update; yum clean all \
    && bash install_yum_deps.sh \
    && bash symlink_libraries.sh \
    && yum clean all \
    && rm -rf /build_scripts

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda install -y git conda-build \
            anaconda-verify constructor libconda

##TODO: binutil 
