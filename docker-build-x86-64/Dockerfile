from phusion/holy-build-box-64:latest

# Install graphical libraries (some packages, such as Matplotlib, require them
#    at test time)
run yes | yum install libX11-devel libSM libXrender
run yes | yum install openssh-clients chrpath
run yes | yum install vim-enhanced vim-common nano
# We provide our own python.  Remove HBB's version.
run rm /hbb/bin/python

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
run curl http://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh -o Miniconda.sh
run /bin/bash Miniconda.sh -b -p /home/dev/miniconda
run CIO_TEST=2 /home/dev/miniconda/bin/conda install --yes git conda-build
env PATH /home/dev/miniconda/bin:$PATH
env LD_LIBRARY_PATH /home/dev/miniconda/lib:$LD_LIBRARY_PATH
env INCLUDE /home/dev/miniconda/include:$INCLUDE
run /bin/bash

# dev aliases
RUN echo "alias clone_recipes='git clone https://github.com/conda/conda-recipes'" >> /home/dev/.bashrc
RUN echo "alias clone_anaconda='git clone git@github.com:continuumIO/anaconda'" >> /home/dev/.bashrc
RUN echo "alias anaconda_setup='clone_anaconda && cd anaconda && git checkout use_hbb && python setup.py develop && cd .. && mkdir aroot'" >> /home/dev/.bashrc
