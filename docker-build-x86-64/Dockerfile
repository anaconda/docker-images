from msarahan/centos5_gcc52_base:latest
MAINTAINER Michael Sarahan <msarahan@continuum.io>

RUN yum install -y libX11-devel.x86_64 libSM.x86_64 libXrender.x86_64 \
        openssh-clients.x86_64 ncurses-devel.x86_64 patch.x86_64 \
        chrpath.x86_64 nano vim-enhanced bzip2 xz sudo curl \
    && yum clean all

# install miniconda
WORKDIR /opt
RUN curl http://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o Miniconda.sh \
    && /bin/bash Miniconda.sh -b -p /opt/miniconda \
    && rm Miniconda.sh \
    && /opt/miniconda/bin/conda install --yes git conda-build curl anaconda-client \
    && /opt/miniconda/bin/conda clean --tarballs --packages \
    && yum remove -y curl \
    && yum clean -y all

RUN useradd -m --uid 1000 -G wheel dev
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# this is where we'll mount shares from the user
RUN mkdir -p /opt/share
ADD internal_startup.sh /opt/share/internal_startup.sh
RUN chmod -R 777 /opt

WORKDIR /home/dev
USER dev
