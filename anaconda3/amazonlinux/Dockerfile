FROM amazonlinux:2.0.20240719.0@sha256:4b425753853906770081d67626d4e8ef63516bb3e056ecbb3c873c57ba74abf1

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# renovate: datasource=custom.anaconda_installer
ARG INSTALLER_URL="https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-aarch64.sh"
ARG SHA256SUM="b4be0ad2052236882402902a31d32cd37635d3db194a42f977be0d68a8ff1a31"

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
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

CMD [ "/bin/bash" ]
