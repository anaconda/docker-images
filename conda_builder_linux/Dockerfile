from continuumio/centos5_gcc5_base:5.11-5.2-0
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

# Yum may have messed up symlinks to libstdc++.  Make sure they are still ours.
RUN ln -sf /usr/local/lib64/libstdc++.so.6.0.21 /usr/lib64/libstdc++.so.6 && \
    ln -sf /usr/local/lib/libstdc++.so.6.0.21 /usr/lib/libstdc++.so.6 && \
    ln -sf /usr/local/lib64/libgcc_s.so.1 /usr/lib64/libgcc_s.so.1 && \
    ln -sf /usr/local/lib/libgcc_s.so.1 /usr/lib/libgcc_s.so.1

RUN useradd -m --uid 1000 -G wheel dev
RUN echo '%wheel ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && \
  echo 'Defaults:%wheel !requiretty' >> /etc/sudoers

# this is where we'll mount shares from the user
RUN mkdir -p /opt/share
ADD build/internal_startup.sh /opt/share/internal_startup.sh
ADD build/alias_32bit.sh /opt/share/alias_32bit.sh
RUN chmod -R 777 /opt

WORKDIR /home/dev
USER dev
