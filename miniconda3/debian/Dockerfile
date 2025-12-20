FROM scratch AS miniconda_installer_amd64
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_LINUX64="https://repo.anaconda.com/miniconda/Miniconda3-py313_25.3.1-1-Linux-x86_64.sh"
ARG SHA256SUM_LINUX64="53a86109463cfd70ba7acab396d416e623012914eee004729e1ecd6fe94e8c69"
ADD --checksum=sha256:${SHA256SUM_LINUX64} ${INSTALLER_URL_LINUX64} /miniconda.sh

FROM scratch AS miniconda_installer_arm64
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_AARCH64="https://repo.anaconda.com/miniconda/Miniconda3-py313_25.3.1-1-Linux-aarch64.sh"
ARG SHA256SUM_AARCH64="4caa0c266ab726b440ccad40a74774167494e001da5de281b74f2d5673e4ace9"
ADD --checksum=sha256:${SHA256SUM_AARCH64} ${INSTALLER_URL_AARCH64} /miniconda.sh

FROM miniconda_installer_${TARGETARCH} AS miniconda_installer

FROM debian:12.11-slim@sha256:6ac2c08566499cc2415926653cf2ed7c3aedac445675a013cc09469c9e118fdd

LABEL maintainer="Anaconda, Inc"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# hadolint ignore=DL3008
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update -q && \
    apt-get install -q -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        mercurial \
        openssh-client \
        procps \
        subversion

ENV PATH=/opt/conda/bin:$PATH

CMD [ "/bin/bash" ]

RUN --mount=type=bind,target=/tmp/miniconda.sh,source=/miniconda.sh,from=miniconda_installer \
    set -x && \
    mkdir -p /opt && \
    bash /tmp/miniconda.sh -b -p /opt/conda && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy
