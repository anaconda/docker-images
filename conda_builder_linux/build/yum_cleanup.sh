yum -y erase wireless-tools gtk2 hicolor-icon-theme \
    avahi freetype bitstream-vera-fonts curl > /dev/null 2>&1
yum -y clean all

# print out all installed packages, and then again by size
yum list installed
rpm -qa --queryformat '%10{size} - %-25{name} \t %{version}\n' | sort -n
