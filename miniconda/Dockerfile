FROM centos:centos6

MAINTAINER Travis Swicegood

RUN yum install -y wget tar bzip2
RUN echo 'export PATH=/opt/anaconda/bin:$PATH' >> ~/.bashrc
RUN mkdir -p /opt
RUN wget --quiet http://repo.continuum.io/miniconda/Miniconda3-3.5.5-Linux-x86_64.sh
RUN /bin/bash /Miniconda3-3.5.5-Linux-x86_64.sh -b -p /opt/anaconda
