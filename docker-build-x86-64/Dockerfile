from msarahan/centos5_gcc52_base:latest
MAINTAINER Michael Sarahan <msarahan@continuum.io>

run yum install -y libX11-devel.x86_64 libSM.x86_64 libXrender.x86_64 openssh-clients.x86_64 ncurses-devel.x86_64 patch.x86_64 chrpath.x86_64 \
    && yum clean all

# Setup home environment
run useradd --uid=1000 dev
run mkdir -p /home/dev && chown -R dev: /home/dev
run chmod 777 /opt
workdir /home/dev
env HOME /home/dev

run chown -R dev: /home/dev
user dev

# install miniconda
workdir /home/dev
run curl http://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o Miniconda.sh \
    && /bin/bash Miniconda.sh -b -p /home/dev/miniconda \
    && rm Miniconda.sh \
    && /home/dev/miniconda/bin/conda install --yes git conda-build \
    && /home/dev/miniconda/bin/conda clean --tarballs --packages
env PATH /home/dev/miniconda/bin:$PATH
env LD_LIBRARY_PATH /home/dev/miniconda/lib:$LD_LIBRARY_PATH
env INCLUDE /home/dev/miniconda/include:$INCLUDE
run /bin/bash

# dev aliases
RUN echo "alias clone_recipes='git clone https://github.com/conda/conda-recipes'" >> /home/dev/.bashrc
# Continuum internal build system (private repo, requires on-site or VPN, may require Docker VM restart if network settings change)
RUN echo "alias clone_anaconda='git clone git@github.com:continuumIO/anaconda'" >> /home/dev/.bashrc
RUN echo "alias anaconda_setup='clone_anaconda && cd anaconda && git checkout use_hbb && python setup.py develop && cd .. && mkdir aroot'" >> /home/dev/.bashrc
