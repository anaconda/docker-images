from msarahan/centos5_gcc52_base:latest
MAINTAINER Michael Sarahan <msarahan@continuum.io>

RUN yum install -y libX11-devel.x86_64 libSM.x86_64 libXrender.x86_64 \
        openssh-clients.x86_64 ncurses-devel.x86_64 patch.x86_64 \
        chrpath.x86_64 nano vim-enhanced bzip2 xz sudo \
    && yum clean all

# Setup home environment
run useradd --uid=1000 dev -G wheel
run mkdir -p /home/dev && chown -R dev: /home/dev
run chmod 777 /opt
run echo "%wheel         ALL = (ALL) NOPASSWD: ALL" >> /etc/sudoers
workdir /home/dev
env HOME /home/dev

ADD startup.sh /home/dev/startup.sh

# install miniconda
workdir /home/dev
run yum install -y curl \
    && curl http://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o Miniconda.sh \
    && /bin/bash Miniconda.sh -b -p /home/dev/miniconda \
    && rm Miniconda.sh \
    && /home/dev/miniconda/bin/conda install --yes git conda-build \
       anaconda-client curl \
    && /home/dev/miniconda/bin/conda clean --tarballs --packages \
    && yum remove -y curl
run chown dev:dev /home/dev -R
user dev
env PATH /home/dev/miniconda/bin:$PATH
env LD_LIBRARY_PATH /home/dev/miniconda/lib:$LD_LIBRARY_PATH

