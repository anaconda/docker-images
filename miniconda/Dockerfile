FROM centos:centos6

MAINTAINER Travis Swicegood

RUN yum install -y --quiet wget tar bzip2
RUN echo 'export PATH=/opt/anaconda/bin:$PATH' >> ~/.bashrc
RUN mkdir -p /downloads
RUN mkdir -p /opt
RUN cd /downloads
RUN wget --quiet http://repo.continuum.io/miniconda/Miniconda3-3.5.5-Linux-x86_64.sh
RUN /bin/bash /downloads/Miniconda3-3.5.5-Linux-x86_64.sh -b -p /opt/anaconda
RUN rm -rf /downloads
