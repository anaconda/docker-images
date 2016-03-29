# Stop at any error, show all commands
set -ex

GCC_VER=5.2.0
GMP_VER=6.1.0
MPC_VER=1.0.3
MPFR_VER=3.1.4
ISL_VER=0.14

# build gcc 5.2.0 (http://en.librehat.com/blog/build-gcc-5-dot-2-on-rhel-6/)
urls="http://mirrors-usa.go-parts.com/gcc/releases/gcc-${GCC_VER}/gcc-${GCC_VER}.tar.bz2 \
         http://gnu.askapache.com/gmp/gmp-${GMP_VER}.tar.bz2 \
         ftp://ftp.gnu.org/gnu/mpc/mpc-${MPC_VER}.tar.gz \
         http://www.mpfr.org/mpfr-current/mpfr-${MPFR_VER}.tar.bz2 \
         ftp://gcc.gnu.org/pub/gcc/infrastructure/isl-${ISL_VER}.tar.bz2"
for url in $urls; do
   curl $url -LO ;
done
wait
mkdir /gcc-build && tar xjf gcc-${GCC_VER}.tar.bz2 -C /gcc-build --strip-components=1
mkdir /gcc-build/gmp && tar xjf gmp-${GMP_VER}.tar.bz2 -C /gcc-build/gmp --strip-components=1
mkdir /gcc-build/mpc && tar xf mpc-${MPC_VER}.tar.gz -C /gcc-build/mpc --strip-components=1
mkdir /gcc-build/mpfr && tar xjf mpfr-${MPFR_VER}.tar.bz2 -C /gcc-build/mpfr --strip-components=1
mkdir /gcc-build/isl && tar xjf isl-${ISL_VER}.tar.bz2 -C /gcc-build/isl --strip-components=1
rm -rf *tar\.*
mkdir /gcc-build/work
cd /gcc-build/work
curl -LO http://ftp.gnu.org/gnu/binutils/binutils-2.26.tar.bz2
tar xf binutils-2.26.tar.bz2
cd /gcc-build/work/binutils-2.26
scl enable devtoolset-2 './configure --prefix=/usr/local \
                                     --enable-plugin     \
                                     --with-sysroot=/    \
                                     --enable-targets=x86_64-redhat-linux-gnu,i686-redhat-linux-gnu \
                         && make -j$(getconf _NPROCESSORS_ONLN) && make install'
cd /gcc-build/work

scl enable devtoolset-2 '/gcc-build/configure \
      --build x86_64-redhat-linux-gnu \
      --enable-__cxa_atexit \
      --enable-bootstrap \
      --enable-checking=release \
      --enable-clocale=gnu \
      --enable-languages=c,c++,fortran,lto \
      --enable-libstdcxx-threads \
      --enable-libstdcxx-time \
      --enable-linker-build-id \
      --enable-multilib \
      --enable-plugin \
      --enable-shared \
      --enable-threads=posix \
      --disable-gnu-unique-object \
      --disable-libada \
      --disable-libgcj \
      --disable-libquadmath-support \
      --disable-libstdcxx-pch \
      --disable-libunwind-exceptions \
      --host x86_64-redhat-linux-gnu \
      --prefix=/usr/local \
      --target=x86_64-redhat-linux-gnu \
      --with-ld=/usr/local/bin/ld \
      --with-linker-hash-style=gnu \
      --with-tune=generic'
scl enable devtoolset-2 'make -j$(getconf _NPROCESSORS_ONLN) bootstrap-lean'
scl enable devtoolset-2 'make install-strip'
ln -sf /usr/local/bin/gcc /usr/local/bin/cc
rm -rf /gcc-build
rm -rf /usr/local/gcc_tmp

