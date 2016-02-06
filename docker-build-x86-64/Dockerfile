from centos:5.11
MAINTAINER Michael Sarahan <msarahan@continuum.io>

# build gcc 5.2.0 (http://en.librehat.com/blog/build-gcc-5-dot-2-on-rhel-6/)
run yum install -y curl.x86_64 bzip2.x86_64 \
    && urls="http://ftpmirror.gnu.org/gcc/gcc-5.2.0/gcc-5.2.0.tar.bz2 \
                https://gmplib.org/download/gmp/gmp-6.0.0a.tar.bz2 \
                ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz \
                http://www.mpfr.org/mpfr-current/mpfr-3.1.3.tar.bz2" \
    && for url in $urls; do \
          curl $url -LO -s & \
       done \
    && wait \
    && mkdir /gcc-build && tar xjf gcc-5.2.0.tar.bz2 -C /gcc-build --strip-components=1 \
    && mkdir /gcc-build/gmp && tar xjf gmp-6.0.0a.tar.bz2 -C /gcc-build/gmp --strip-components=1 \
    && mkdir /gcc-build/mpc && tar xf mpc-1.0.3.tar.gz -C /gcc-build/mpc --strip-components=1 \
    && mkdir /gcc-build/mpfr && tar xjf mpfr-3.1.3.tar.bz2 -C /gcc-build/mpfr --strip-components=1 \
    && rm -rf *tar\.* \
    && mkdir /gcc-build/work \
    && cd /gcc-build/work \
    && curl http://linuxsoft.cern.ch/cern/devtoolset/slc5-devtoolset.repo -o /etc/yum.repos.d/slc5-devtoolset.repo \
    && rpm --import http://ftp.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/51/i386/RPM-GPG-KEYs/RPM-GPG-KEY-cern \
    && yum install -y make centos-release-SCL devtoolset-2 libtool.x86_64 pkgconfig.x86_64 \
    && curl -LO http://ftp.gnu.org/gnu/binutils/binutils-2.26.tar.bz2 \
    && tar xf binutils-2.26.tar.bz2 \
    && cd /gcc-build/work/binutils-2.26 \
    && scl enable devtoolset-2 './configure --prefix=/usr \
                                            --enable-plugin \
                                && make -j$(getconf _NPROCESSORS_ONLN) && make install' \
    && cd /gcc-build/work \
    && scl enable devtoolset-2 '/gcc-build/configure \
             --prefix=/usr \
             --disable-multilib \
             --enable-languages=c,c++,fortran \
             --enable-libstdcxx-threads \
             --enable-libstdcxx-time \
             --enable-shared \
             --enable-__cxa_atexit \
             --disable-libunwind-exceptions \
             --disable-libada \
             --host x86_64-redhat-linux-gnu \
             --build x86_64-redhat-linux-gnu \
             --enable-plugin \
             --enable-lto \
             --with-default-libstdcxx-abi=gcc4-compatible' \
    && scl enable devtoolset-2 'make -j$(getconf _NPROCESSORS_ONLN)' \
    && scl enable devtoolset-2 'make install' \
    && yum remove -y devtoolset-2 \
    && rm /etc/yum.repos.d/slc5-devtoolset.repo \
    && rm -rf /gcc-build/work \
    && mkdir /gcc-build/work \
    && /gcc-build/configure --disable-multilib \
             --prefix=/usr \
             --enable-languages=c,c++,fortran \
             --enable-libstdcxx-threads \
             --enable-libstdcxx-time \
             --enable-shared \
             --enable-__cxa_atexit \
             --disable-libunwind-exceptions \
             --disable-libada \
             --host x86_64-redhat-linux-gnu \
             --build x86_64-redhat-linux-gnu \
             --enable-plugin \
             --enable-lto \
             --with-default-libstdcxx-abi=gcc4-compatible \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && run make install \
    && rm -rf /gcc-build
    && yum install -y libX11-devel.x86-64 libS.x86-64M libXrende.x86-64r openssh-client.x86-64s chrpath.x86-64 vim-enhanced.x86-64 vim-common.x86-64 nano.x86-64
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
