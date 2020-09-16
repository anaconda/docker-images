FROM debian:buster-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

ENV PYTHON_VERSION 2.7

RUN useradd -ms /bin/bash test_user

RUN usermod -u 1001 test_user
RUN groupmod -g 1001 test_user

RUN apt-get update --fix-missing && \
    apt-get install -y wget build-essential bzip2 ca-certificates libglib2.0-0 libxext6 libsm6 libxrender1 git mercurial subversion sudo && \
    apt-get clean

RUN echo "test_user ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    /opt/conda/bin/conda clean -tipsy

# conda and test dependencies
RUN /opt/conda/bin/conda install -y -c conda-canary -c defaults \
    conda conda-package-handling \
    python=$PYTHON_VERSION pycosat requests ruamel_yaml cytoolz \
    anaconda-client nbformat make \
    pytest pytest-cov pytest-timeout mock responses pexpect \
    flake8 enum34 futures && \
    /opt/conda/bin/conda clean --all --yes

RUN /opt/conda/bin/pip install codecov radon \
  && rm -rf ~root/.cache/pip

# conda-build and test dependencies
RUN sudo /opt/conda/bin/conda install -y -c conda-canary -c defaults \
        conda-build patch git \
        perl pytest-xdist pytest-mock \
        anaconda-client \
        filelock jinja2 conda-verify pkginfo \
        glob2 beautifulsoup4 chardet pycrypto \
    && sudo /opt/conda/bin/conda clean --all --yes

USER test_user

ENTRYPOINT [ "/bin/bash" ]
