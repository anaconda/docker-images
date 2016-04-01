from continuumio/centos5_gcc5_base:5.11-5.2-1
MAINTAINER Michael Sarahan <msarahan@continuum.io>

WORKDIR /build_scripts
COPY build/yum_install_syslibs.sh \
     build/install_miniconda.sh \
     build/yum_cleanup.sh \
     /build_scripts/

RUN bash yum_install_syslibs.sh && \
    bash install_miniconda.sh && \
    bash yum_cleanup.sh && \
    rm -rf /build_scripts && \
    mkdir -p /opt/share && \
    mkdir -p /opt/miniconda/conda-bld/work/linux-64 && \
    mkdir -p /opt/miniconda/conda-bld/work/linux-32 && \
    mkdir -p /opt/miniconda/conda-bld/work/noarch && \
    chmod -R 777 /opt && \
    useradd -m --uid 1000 -G wheel dev && \
    echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
    echo 'Defaults:%wheel !requiretty' >> /etc/sudoers

ADD build/internal_startup.sh /opt/share/internal_startup.sh
ADD build/alias_32bit.sh /opt/share/alias_32bit.sh

WORKDIR /home/dev
USER dev
