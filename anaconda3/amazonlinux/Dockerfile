FROM amazonlinux:2.0.20250623.0@sha256:ce8776f79d55908d613c84226c6ac0b0522b7b35970173e7f91f6af9f7df6fee

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH=/opt/conda/bin:$PATH

# renovate: datasource=custom.anaconda_installer
ARG INSTALLER_URL="https://repo.anaconda.com/archive/Anaconda3-2025.12-2-Linux-aarch64.sh"
ARG SHA256SUM="be13a20f31d82508a061984fa3555369cfd8e4692643721415c19e7dc2e9e0f9"

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
