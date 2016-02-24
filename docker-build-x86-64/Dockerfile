from msarahan/centos5_gcc52_base:latest
MAINTAINER Michael Sarahan <msarahan@continuum.io>

RUN yum install -y libX11-devel.x86_64 libSM.x86_64 libXrender.x86_64 \
        openssh-clients.x86_64 ncurses-devel.x86_64 patch.x86_64 \
        chrpath.x86_64 nano vim-enhanced xz \
    && yum clean all

# install miniconda
WORKDIR /opt
RUN curl http://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o Miniconda.sh \
    && /bin/bash Miniconda.sh -b -p /opt/miniconda \
    && rm Miniconda.sh \
    && /opt/miniconda/bin/conda install --yes git conda-build \
    && /opt/miniconda/bin/conda clean --tarballs --packages

# this is where we'll mount shares from the user
RUN mkdir -p /opt/share
