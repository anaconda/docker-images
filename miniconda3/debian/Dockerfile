FROM scratch AS miniconda_installer_amd64
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_LINUX64="https://repo.anaconda.com/miniconda/Miniconda3-py314_26.7.1-1-Linux-x86_64.sh"
ARG SHA256SUM_LINUX64="e8b25b92b262499141c5bd57a98d3c008024185fa951494b9cd9b6d94e72338b"
ADD --checksum=sha256:${SHA256SUM_LINUX64} ${INSTALLER_URL_LINUX64} /miniconda.sh

FROM scratch AS miniconda_installer_arm64
# renovate: datasource=custom.miniconda_installer
ARG INSTALLER_URL_AARCH64="https://repo.anaconda.com/miniconda/Miniconda3-py314_26.7.1-1-Linux-aarch64.sh"
ARG SHA256SUM_AARCH64="e31545afd7462d3c9c33b154c7a101c5acb5e01b69380b6994651aead6942893"
ADD --checksum=sha256:${SHA256SUM_AARCH64} ${INSTALLER_URL_AARCH64} /miniconda.sh

FROM miniconda_installer_${TARGETARCH} AS miniconda_installer

FROM debian:13.6-slim@sha256:d7e12182ce18b85b93007c1dedf31f2d29e01ccf3182cc4017c709b6259bc132

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

ARG DEPRECATION_MESSAGE="::warning::This image is deprecated.\n\n\
Updates to this image will be discontinued after Miniconda version \`26.7.x\`. \
The latest Miniconda Docker images are available as \`anaconda/miniconda\`. \
For more information, visit: https://hub.docker.com/r/anaconda/miniconda\n"

# Deprecation warning script
RUN printf '#!/bin/bash\nprintf "'%s'" >&2\nexec "$@"\n' "${DEPRECATION_MESSAGE}" \
    > /usr/local/bin/docker-entrypoint.sh && \
    chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
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
