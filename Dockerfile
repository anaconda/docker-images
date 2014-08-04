FROM centos:centos6

MAINTAINER Travis Swicegood version 3.5.5

RUN yum install -y --quiet wget tar bzip2 && \
	mkdir -p /downloads && \
	mkdir -p /opt && \
	cd /downloads && \
	echo "Downloading Miniconda..." && \
	wget --quiet http://repo.continuum.io/miniconda/Miniconda3-3.5.5-Linux-x86_64.sh && \
	/bin/bash /downloads/Miniconda3-3.5.5-Linux-x86_64.sh -b -p /opt/anaconda && \
	rm -rf /downloads && \
	echo 'export PATH=/opt/anaconda/bin:$PATH' >> ~/.bashrc
