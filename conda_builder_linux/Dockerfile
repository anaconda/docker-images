from msarahan/centos5_gcc52_base:latest
MAINTAINER Michael Sarahan <msarahan@continuum.io>

WORKDIR /build_scripts
COPY build/yum_install_syslibs.sh \
     build/install_miniconda.sh \
     build/yum_cleanup.sh \
     /build_scripts/

RUN bash yum_install_syslibs.sh && \
    bash install_miniconda.sh && \
    bash yum_cleanup.sh && \
    rm -rf /build_scripts

RUN useradd -m --uid 1000 -G wheel dev
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# this is where we'll mount shares from the user
RUN mkdir -p /opt/share
ADD build/internal_startup.sh /opt/share/internal_startup.sh
RUN chmod -R 777 /opt

WORKDIR /home/dev
USER dev
