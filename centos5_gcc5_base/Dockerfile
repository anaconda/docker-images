from centos:5.11
MAINTAINER Michael Sarahan <msarahan@continuum.io>

WORKDIR /build_scripts
COPY install_yum_deps.sh build_gcc.sh yum_cleanup.sh /build_scripts/
RUN bash install_yum_deps.sh && \
    bash build_gcc.sh && \
    bash yum_cleanup.sh && \
    rm -rf /build_scripts
