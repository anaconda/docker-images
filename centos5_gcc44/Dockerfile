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

RUN curl -sS https://ftp.gnu.org/gnu/binutils/binutils-2.27.tar.gz -o /tmp/binutils.tar.gz \
    && cd /tmp \
    && tar -xvzf binutils.tar.gz \
    && cd binutils-2.27/ \
    && chmod +x configure \
    && ./configure \
    && make \
    && make install \
    && rm -rf /tmp/*

WORKDIR /temp
RUN wget --quiet http://mirror.ox.ac.uk/sites/ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz  \
    && tar -xf install-tl-unx.tar.gz \
    && cd $(ls -d */|head -n 1) \
    && TEXLIVE_INSTALL_PREFIX=/opt/texlive ./install-tl \
    && rm -rf /temp/*

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda install -y git conda-build \
            anaconda-verify constructor libconda
