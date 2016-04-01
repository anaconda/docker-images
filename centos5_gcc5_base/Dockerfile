FROM centos:5.11
MAINTAINER Michael Sarahan <msarahan@continuum.io>

WORKDIR /build_scripts
COPY install_yum_deps.sh build_gcc.sh yum_cleanup.sh symlink_libraries.sh /build_scripts/
RUN bash install_yum_deps.sh && \
    bash build_gcc.sh && \
    bash yum_cleanup.sh && \
    bash symlink_libraries.sh && \
    rm -rf /build_scripts
