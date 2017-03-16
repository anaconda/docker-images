yum install -y curl.x86_64 bzip2.x86_64 yum-utils glibc-devel patch \
    unzip bison yasm file make libtool.x86_64 pkgconfig.x86_64 \
    ison byacc cscope ctags cvs diffstat doxygen flex gettext \
    indent intltool libtool curl bzip2 wget swig systemtap\
    patch patchutils rcs redhat-rpm-config rpm-build subversion \
    centos-release-SCL devtoolset-2 tar.x86_64 unzip
    emacs vim-enhanced nano \

yum install -y  gcc44 gcc44-c++ gcc44-gfortran mesa-libGL-devel \
                 mesa-libGLU-devel libX11-devel libXt-devel \
                 libXrender-devel libXext-devel libXdmcp-devel \
                 java-1.7.0-openjdk java-1.7.0-openjdk-devel libgcj

ln -s /usr/bin/gcc44 /usr/local/bin/gcc
ln -s /usr/bin/g++44 /usr/local/bin/g++
ln -s /usr/bin/gfortran44 /usr/local/bin/gfortran
