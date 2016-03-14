yum install -y curl.x86_64 bzip2.x86_64 yum-utils glibc-devel
yum -y install bzip2 make git patch unzip bison yasm diffutils autoconf automake which file
curl http://linuxsoft.cern.ch/cern/devtoolset/slc5-devtoolset.repo -o /etc/yum.repos.d/slc5-devtoolset.repo
rpm --import http://ftp.mirrorservice.org/sites/ftp.scientificlinux.org/linux/scientific/51/i386/RPM-GPG-KEYs/RPM-GPG-KEY-cern
yum install -y make centos-release-SCL devtoolset-2 libtool.x86_64 pkgconfig.x86_64
