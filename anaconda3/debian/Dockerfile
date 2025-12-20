FROM scratch AS anaconda_installer_amd64
# renovate: datasource=custom.anaconda_installer
ARG INSTALLER_URL_LINUX64="https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-x86_64.sh"
ARG SHA256SUM_LINUX64="3ba0a298155c32fbfd80cbc238298560bf69a2df511783054adfc151b76d80d8"
ADD --checksum=sha256:${SHA256SUM_LINUX64} ${INSTALLER_URL_LINUX64} /anaconda.sh

FROM scratch AS anaconda_installer_s390x
# renovate: datasource=custom.anaconda_installer
ARG INSTALLER_URL_S390X="https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-s390x.sh"
ARG SHA256SUM_S390X="e00bd5e6c275695e8050a45aa85790315f504c95243dfe3632f505284310f3c4"
ADD --checksum=sha256:${SHA256SUM_S390X} ${INSTALLER_URL_S390X} /anaconda.sh

FROM scratch AS anaconda_installer_arm64
# renovate: datasource=custom.anaconda_installer
ARG INSTALLER_URL_AARCH64="https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-aarch64.sh"
ARG SHA256SUM_AARCH64="489c608e8bddd2cf29dfbdd811cf99087cd6b6a0615d41c6f9058ce340594b65"
ADD --checksum=sha256:${SHA256SUM_AARCH64} ${INSTALLER_URL_AARCH64} /anaconda.sh

FROM anaconda_installer_${TARGETARCH} AS anaconda_installer

FROM debian:12.11-slim@sha256:6ac2c08566499cc2415926653cf2ed7c3aedac445675a013cc09469c9e118fdd

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/conda/bin:$PATH

# hadolint ignore=DL3008
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    --mount=type=bind,target=/tmp/anaconda.sh,source=/anaconda.sh,from=anaconda_installer \
    apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libsm6 \
        libxcomposite1 \
        libxcursor1 \
        libxdamage1 \
        libxext6 \
        libxfixes3 \
        libxi6 \
        libxinerama1 \
        libxrandr2 \
        libxrender1 \
        mercurial \
        openssh-client \
        procps \
        subversion \
    && set -x && \
    /bin/bash /tmp/anaconda.sh -b -p /opt/conda && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

CMD [ "/bin/bash" ]
