from centos:5.11
MAINTAINER Michael Sarahan <msarahan@continuum.io>

# build gcc 5.2.0 (http://en.librehat.com/blog/build-gcc-5-dot-2-on-rhel-6/)
run yum install -y curl.x86_64 bzip2.x86_64 yum-utils glibc-devel.i386 glibc-devel.x86_64 \
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
                                            --with-sysroot=/ \
                                            --target=x86_64-redhat-linux-gnu \
                                            --enable-targets=x86_64-redhat-linux-gnu,i386-redhat-linux-gnu \
                                && make -j$(getconf _NPROCESSORS_ONLN) && make install' \
    && cd /gcc-build/work \
    && scl enable devtoolset-2 '/gcc-build/configure \
             --prefix=/usr \
             --enable-multilib \
             --target=x86_64-redhat-linux-gnu \
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
             --disable-libunwind-exceptions --enable-clocale=gnu \
             --disable-libstdcxx-pch \
             --with-default-libstdcxx-abi=gcc4-compatible' \
    && scl enable devtoolset-2 'make -j$(getconf _NPROCESSORS_ONLN) all' \
    && scl enable devtoolset-2 'make install' \
    && yum remove -y devtoolset-2 \
    && rm -rf /opt/rh \
    && rm /etc/yum.repos.d/slc5-devtoolset.repo \
    && cd / \
    && rm -rf /gcc-build/work \
    && mkdir /gcc-build/work \
    && cd /gcc-build/work \
    && /gcc-build/configure \
    && /gcc-build/configure \
             --prefix=/usr \
             --enable-multilib \
             --target=x86_64-redhat-linux-gnu \
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
             --disable-libunwind-exceptions --enable-clocale=gnu \
             --disable-libstdcxx-pch \
             --with-default-libstdcxx-abi=gcc4-compatible \
    && make -j$(getconf _NPROCESSORS_ONLN) \
    && make install-strip \
    && cd / \
    && rm -rf /gcc-build \
    && yum clean all
