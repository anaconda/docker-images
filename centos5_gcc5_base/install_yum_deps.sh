yum install -y curl.x86_64 bzip2.x86_64 yum-utils glibc-devel patch \
    unzip bison yasm file make libtool.x86_64 pkgconfig.x86_64
curl http://linuxsoft.cern.ch/cern/devtoolset/slc5-devtoolset.repo -o /etc/yum.repos.d/slc5-devtoolset.repo
rpm --import http://ftp.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/51/i386/RPM-GPG-KEYs/RPM-GPG-KEY-cern
yum install -y centos-release-SCL devtoolset-2
