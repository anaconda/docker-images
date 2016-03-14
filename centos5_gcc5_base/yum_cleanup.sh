yum remove -y devtoolset-2 curl binutils
rm -rf /opt/rh
rm /etc/yum.repos.d/slc5-devtoolset.repo
yum clean all
