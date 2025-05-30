# Dockerfile for container images that Anaconda, Inc. uses to build conda
# packages released on the "defaults" (repo.anaconda.com) channels.

ARG GCC_VER=11.2.0

FROM almalinux:8.10-20240923@sha256:d7dbaf57916185b2be09e1eaa1156b543f3937164ffa08d7fdc020a0a3800a5a

# hadolint ignore=DL3031,DL3033
RUN \
    # Hack to force locale generation, if needed
    yum update -q -y glibc-common \
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
ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

# this should not be renovated. If it is, conda-build v24.1.2 won't be able to
# be installed, which will make this image not usable in Anaconda's current CI
ARG INSTALLER_VERSION=py312_24.5.0-0

RUN curl -sSL -o /tmp/miniconda.sh \
        "https://repo.anaconda.com/miniconda/Miniconda3-${INSTALLER_VERSION}-Linux-$(uname -m)".sh \
    && sha256sum /tmp/miniconda.sh \
    && /bin/bash /tmp/miniconda.sh -bfp /opt/conda \
    && rm -fv /tmp/miniconda.sh \
    # ensure there are no out of range userids
    && chown -R root:root /opt/conda

# hadolint ignore=DL3059
RUN MC_ARCH="$(uname -m)" \
    && if [ "${MC_ARCH}" = "x86_64" ]; then subdir="64"; else subdir="${MC_ARCH}"; fi \
    && /opt/conda/bin/conda update --all --quiet --yes \
    && /opt/conda/bin/conda install --quiet --yes conda-build=24.1.2 \
    && /opt/conda/bin/conda clean --all --yes \
    && rm -fv /opt/conda/.condarc \
    && /opt/conda/bin/conda config --system --set show_channel_urls True \
    && /opt/conda/bin/conda config --system --set add_pip_as_python_dependency False \
    && /opt/conda/bin/conda config --show-sources \
    # Cache our C and C++ compilers so we don't have to download them with
    # each build; skipping the Fortran compiler as it's not used often
    # enough to justify the cache space.  Note that we do NOT want to
    # _actually install_ the compilers in the base environment, as doing so
    # runs the risk of buggy recipes falling back to those compilers via
    # `$PATH`, rather than erroring out due to missing compilers in the
    # `build`/`host` requirements.
    #
    # Note, too, that this MUST come _after_ the `conda clean --all` above,
    # or the compilers will be dumped from the package cache.
    && /opt/conda/bin/conda install --download-only --quiet --yes \
        "gcc_linux-$subdir=${GCC_VER}" "gxx_linux-$subdir=${GCC_VER}" \
    && /opt/conda/bin/conda clean --index-cache --yes

ENV PATH="/opt/conda/bin:${PATH}"

CMD [ "/bin/bash" ]
