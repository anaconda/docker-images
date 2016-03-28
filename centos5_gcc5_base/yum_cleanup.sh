yum remove -y devtoolset-2* curl binutils kernel
rm -rf /opt/rh
rm /etc/yum.repos.d/slc5-devtoolset.repo
yum -y remove wireless-tools gtk2 libX11 hicolor-icon-theme \
    avahi freetype bitstream-vera-fonts > /dev/null 2>&1
yum clean all

# print out all installed packages, and then again by size
yum list installed
rpm -qa --queryformat '%10{size} - %-25{name} \t %{version}\n' | sort -n
