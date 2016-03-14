yum remove -y devtoolset-2 curl binutils
rm -rf /opt/rh
rm /etc/yum.repos.d/slc5-devtoolset.repo
yum -y erase wireless-tools gtk2 libX11 hicolor-icon-theme \
    avahi freetype bitstream-vera-fonts devtoolset-2-libstdc++-devel \
    devtoolset-2-binutils devtoolset-2-valgrind > /dev/null 2>&1
yum clean all
