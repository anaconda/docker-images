FROM centos:centos6
MAINTAINER Continuum Analytics, Inc. <conda@continuum.io>

ENV container docker
WORKDIR /build_scripts
RUN yum -y update; yum clean all \
    && yum install -y curl.x86_64 bzip2.x86_64 yum-utils glibc-devel patch \
        unzip bison yasm file make libtool.x86_64 pkgconfig.x86_64 \
        ison byacc cscope ctags cvs diffstat doxygen flex gettext \
        indent intltool libtool curl bzip2 wget swig systemtap\
        patch patchutils rcs redhat-rpm-config rpm-build subversion \
        centos-release-SCL devtoolset-2 tar.x86_64 unzip \
        emacs vim-enhanced nano \
    &&  yum install -y  gcc44 gcc44-c++ gcc44-gfortran mesa-libGL-devel \
                         mesa-libGLU-devel libX11-devel libXt-devel \
                         libXrender-devel libXext-devel libXdmcp-devel \
                         java-1.7.0-openjdk java-1.7.0-openjdk-devel libgcj \

    && yum clean all \
    && rm -rf /build_scripts

RUN ln -s /usr/bin/gcc44 /usr/local/bin/gcc \
    && ln -s /usr/bin/g++44 /usr/local/bin/g++ \ 
    && ln -s /usr/bin/gfortran44 /usr/local/bin/gfortran


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
    && rm -rf /temp

RUN wget --quiet https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh -O ~/miniconda.sh \
    && /bin/bash ~/miniconda.sh -b -p /opt/conda \
    && rm ~/miniconda.sh

ENV PATH /opt/conda/bin:$PATH

RUN conda install -y git conda-build \
            anaconda-verify constructor libconda

ENV CONCOURSE_VERSION="3.0.1"
RUN curl -L https://github.com/concourse/concourse/releases/download/v${CONCOURSE_VERSION}/concourse_linux_amd64 -o /usr/local/bin/concourse \
 && chmod 755 /usr/local/bin/concourse
