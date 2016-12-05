FROM centos:5.11
MAINTAINER Michael Sarahan <msarahan@continuum.io>

RUN yum install -y glib2-devel libX11-devel libXext-devel libXrender-devel  \
    mesa-libGL-devel libICE-devel libSM-devel ncurses-devel \
    openssh-clients.x86_64 patch.x86_64 dbus-devel gtk2-devel \
    chrpath.x86_64 nano bzip2 xz sudo curl && \
    yum -y erase wireless-tools avahi > /dev/null 2>&1 && \
    yum -y clean all

RUN echo 'export PATH=/opt/conda/bin:$PATH' > /etc/profile.d/conda.sh && \
    curl -LO https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh && \
    /bin/bash Miniconda2-latest-Linux-x86_64.sh -b -p /opt/conda && \
    rm Miniconda2-latest-Linux-x86_64.sh && \
    source ~/.bashrc && \
    conda install -yq -c msarahan conda-build git curl anaconda-client && \
    conda clean -pt && yum erase -y curl

ENV PATH /opt/conda/bin:$PATH

RUN TINI_VERSION=`curl https://github.com/krallin/tini/releases/latest | grep -o "/v.*\"" | sed 's:^..\(.*\).$:\1:'` && \
    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" > /usr/bin/tini && \
    chmod +x /usr/bin/tini

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
