# Dockerfile for container images that Anaconda, Inc. uses to build conda
# packages released on the "defaults" (repo.anaconda.com) channels.

ARG GCC_VER=14.3.0

FROM rockylinux:8.9.20231119@sha256:9794037624aaa6212aeada1d28861ef5e0a935adaf93e4ef79837119f2a2d04c

# hadolint ignore=DL3031,DL3033
RUN \
    # Hack to force locale generation, if needed
    yum update -q -y glibc-common \
    && yum install -q -y \
        #----------------------------------------
        # X11 virtual framebuffer; useful for testing GUI apps
        #----------------------------------------
        xorg-x11-server-Xvfb \
        #----------------------------------------
        # Low-level and basic system utilities.
        #
        # NOTE: previous versions of this image included tools like `patch`
        # and `make`; these days, we prefer package recipes list the
        # equivalent conda packages as build dependencies, rather than
        # assume the build container provides these tools.
        #----------------------------------------
        curl \
        diffutils \
        file \
        findutils \
        nano \
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

# renovate: datasource=custom.miniconda_installer depName=Linux-x86_64.sh
ARG INSTALLER_VERSION=py313_25.3.1-1

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
    && /opt/conda/bin/conda install --quiet --yes conda-build \
    && /opt/conda/bin/conda clean --all --yes \
    && rm -fv /opt/conda/.condarc \
    && /opt/conda/bin/conda config --system --add channels defaults \
    && /opt/conda/bin/conda config --system --set show_channel_urls True \
    && /opt/conda/bin/conda config --system --set add_pip_as_python_dependency False \
    && /opt/conda/bin/conda config --system --set report_errors False \
    && /opt/conda/bin/conda config --system --set conda_build.pkg_format ".tar.bz2" \
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
