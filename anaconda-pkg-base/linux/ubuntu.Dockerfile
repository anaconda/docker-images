ARG BASEVERSION=focal-20241011@sha256:e341aa0d58bb9480bd092a137658bd1a7a5e8ae4fca31769df0eb7d6c4b8266e

FROM ubuntu:${BASEVERSION}

# hadolint ignore=DL3008
RUN apt-get update \
    # # Hack to force locale generation, if needed
    && apt-get install -q -y --no-install-recommends locales locales-all \
    && apt-get install -q -y --no-install-recommends \
        #----------------------------------------
        # X11-related libraries needed for various CDTs
        #----------------------------------------
        libx11-6 \
        libxau6 \
        libxcb1 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxdmcp6 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxinerama1 \
        libxrandr2 \
        libxrender1 \
        libxss1 \
        libxt6 \
        libxtst6 \
        #----------------------------------------
        # MESA 3D graphics library
        #----------------------------------------
        #mesa-libEGL \
        #mesa-libGL \
        #mesa-libGLU \
        #----------------------------------------
        # X11 virtual framebuffer; useful for testing GUI apps
        #----------------------------------------
        xvfb \
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
        openssh-client \
        psmisc \
        rsync \
        util-linux \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set the locale
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

CMD [ "/usr/bin/bash" ]
