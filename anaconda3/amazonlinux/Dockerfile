FROM scratch AS anaconda_installer_arm64
# renovate: datasource=custom.anaconda_installer
ARG INSTALLER_URL_AARCH64="https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-aarch64.sh"
ARG SHA256SUM_AARCH64="489c608e8bddd2cf29dfbdd811cf99087cd6b6a0615d41c6f9058ce340594b65"
ADD --checksum=sha256:${SHA256SUM_AARCH64} ${INSTALLER_URL_AARCH64} /anaconda.sh

FROM anaconda_installer_${TARGETARCH} AS anaconda_installer

FROM amazonlinux:2.0.20250623.0@sha256:ce8776f79d55908d613c84226c6ac0b0522b7b35970173e7f91f6af9f7df6fee

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/conda/bin:$PATH

# hadolint ignore=DL3008
# hadolint ignore=DL3033
RUN --mount=type=cache,target=/var/cache/yum,sharing=locked \
    --mount=type=bind,target=/tmp/anaconda.sh,source=/anaconda.sh,from=anaconda_installer \
    yum install -y \
        bzip2 \
        ca-certificates \
        libglib2.0-0 \
        libXext \
        libSM \
        libXrender \
        libXcomposite \
        libXcursor \
        libXdamage \
        libXfixes \
        libXi \
        libXinerama \
        libXrandr \
        git \
        mercurial \
        subversion && \
    /bin/bash /tmp/anaconda.sh -b -p /opt/conda && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

CMD [ "/bin/bash" ]
