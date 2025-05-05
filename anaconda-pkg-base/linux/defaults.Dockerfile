FROM centos:7.9.2009@sha256:be65f488b7764ad3638f236b7b515b3678369a5124c47b8d32916d6487418ea4 AS base-amd64

FROM amazonlinux:2.0.20250428.0@sha256:02992032c0054398cfaed02fde628daaa764e5c99e84141808768a78a5897df0 AS base-arm64

FROM clefos:7.7.1908@sha256:2bcecd8dcbee4e8cc4fcffff01e8db2d01d7967507c7e718a160fa29750fa4af AS base-s390x

# hadolint ignore=DL3006
FROM base-$TARGETARCH

# hadolint ignore=DL3031,DL3033
RUN yum install -q -y deltarpm \
    # Hack to force locale generation, if needed
    && yum update -q -y glibc-common \
    && yum install -q -y \
        #----------------------------------------
        # X11-related libraries needed for various CDTs
        #----------------------------------------
        libX11 \
        libXau \
        libxcb \
        libXcomposite \
        libXcursor \
        libXdamage \
        libXdmcp \
        libXext \
        libXfixes \
        libXi \
        libXinerama \
        libXrandr \
        libXrender \
        libXScrnSaver \
        libXt \
        libXtst \
        #----------------------------------------
        # MESA 3D graphics library
        #----------------------------------------
        #mesa-libEGL \
        #mesa-libGL \
        #mesa-libGLU \
        #----------------------------------------
        # Vendor-neutral OpenGL
        #----------------------------------------
        libglvnd-opengl \
        #----------------------------------------
        # X11 virtual framebuffer; useful for testing GUI apps
        #----------------------------------------
        xorg-x11-server-Xvfb \
        #----------------------------------------
        # Other hardware and low-level system libraries
        #----------------------------------------
        #alsa-lib \
        #libselinux \
        #pam \
        #pciutils-libs \
        #----------------------------------------
        # Low-level and basic system utilities.
        #
        # NOTE: previous versions of this image included tools like `patch`
        # and `make`; these days, we prefer package recipes list the
        # equivalent conda packages as build dependencies, rather than
        # assume the build container provides these tools.
        #----------------------------------------
        curl \
        file \
        net-tools \
        openssh-clients \
        procps-ng \
        psmisc \
        rsync \
        tar \
        util-linux \
        #wget \
        which \
    && yum clean all

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD [ "/bin/bash" ]
