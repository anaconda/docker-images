FROM amazonlinux:2.0.20250512.0@sha256:2c8cd67d220dae7cf95b6a79a128d8eb0563ee08a448bade6e6d256674b483c9

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/conda/bin:$PATH

# renovate: datasource=custom.anaconda_installer
ARG INSTALLER_URL="https://repo.anaconda.com/archive/Anaconda3-2024.10-1-Linux-aarch64.sh"
ARG SHA256SUM="489c608e8bddd2cf29dfbdd811cf99087cd6b6a0615d41c6f9058ce340594b65"

# hadolint ignore=DL3008
# hadolint ignore=DL3033
RUN yum install -y \
        wget \
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
    yum clean all && \
    rm -rf /var/cache/yum && \
    wget --quiet ${INSTALLER_URL} -O anaconda.sh && \
    echo "${SHA256SUM} anaconda.sh" > shasum && \
    sha256sum --check --status shasum && \
    /bin/bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

CMD [ "/bin/bash" ]
