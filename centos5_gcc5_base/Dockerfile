FROM centos:5.11
MAINTAINER Michael Sarahan <msarahan@continuum.io>

WORKDIR /build_scripts
COPY install_yum_deps.sh build_gcc.sh yum_cleanup.sh /build_scripts/
RUN bash install_yum_deps.sh && \
    bash build_gcc.sh && \
    bash yum_cleanup.sh && \
    rm -rf /build_scripts
# replace ancient system libstdc++, plug ours in.
# This is a workaround for some recipes that do not respect LIBRARY_PATH.
RUN ln -sf /usr/local/lib64/libstdc++.so.6.0.21 /usr/lib64/libstdc++.so.6
RUN ln -sf /usr/local/lib/libstdc++.so.6.0.21 /usr/lib/libstdc++.so.6
RUN ln -sf /usr/local/lib64/libgcc_s.so.1 /usr/lib64/libgcc_s.so.1
RUN ln -sf /usr/local/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1
