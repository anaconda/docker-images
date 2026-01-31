FROM scratch AS miniconda_installer_amd64
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_LINUX64="https://repo.anaconda.com/miniconda/Miniconda3-py313_25.11.1-1-Linux-x86_64.sh"
ARG SHA256SUM_LINUX64="e0b10e050e8928e2eb9aad2c522ee3b5d31d30048b8a9997663a8a460d538cef"
ADD --checksum=sha256:${SHA256SUM_LINUX64} ${INSTALLER_URL_LINUX64} /miniconda.sh

FROM scratch AS miniconda_installer_arm64
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_AARCH64="https://repo.anaconda.com/miniconda/Miniconda3-py313_25.11.1-1-Linux-aarch64.sh"
ARG SHA256SUM_AARCH64="9f39cc8c46ca37afed5e563cc234b3add34fea2f1119e076dcae7a377ca6b8ee"
ADD --checksum=sha256:${SHA256SUM_AARCH64} ${INSTALLER_URL_AARCH64} /miniconda.sh

FROM miniconda_installer_${TARGETARCH} AS miniconda_installer

FROM debian:13.3-slim@sha256:77ba0164de17b88dd0bf6cdc8f65569e6e5fa6cd256562998b62553134a00ef0

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
    /opt/conda/bin/conda tos accept && \
    /opt/conda/bin/conda remove --force-remove -y conda-anaconda-tos && \
    rm -rf ~/.conda/tos && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy
