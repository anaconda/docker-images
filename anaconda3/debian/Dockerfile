FROM debian:bullseye-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

ARG INSTALLER_URL_LINUX64="https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-x86_64.sh"
ARG SHA256SUM_LINUX64="6c8a4abb36fbb711dc055b7049a23bbfd61d356de9468b41c5140f8a11abd851"
ARG INSTALLER_URL_S390X="https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-s390x.sh"
ARG SHA256SUM_S390X="ee817071a2ad94e044fb48061a721bc86606b2f4906b705e4f42177eeb3ca7c5"
ARG INSTALLER_URL_AARCH64="https://repo.anaconda.com/archive/Anaconda3-2023.09-0-Linux-aarch64.sh"
ARG SHA256SUM_AARCH64="69ee26361c1ec974199bce5c0369e3e9a71541de7979d2b9cfa4af556d1ae0ea"

# hadolint ignore=DL3008
RUN set -x && \
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
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        INSTALLER_URL=${INSTALLER_URL_LINUX64}; \
        SHA256SUM=${SHA256SUM_LINUX64}; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
        INSTALLER_URL=${INSTALLER_URL_S390X}; \
        SHA256SUM=${SHA256SUM_S390X}; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
        INSTALLER_URL=${INSTALLER_URL_AARCH64}; \
        SHA256SUM=${SHA256SUM_AARCH64}; \
    fi && \
    wget "${INSTALLER_URL}" -O anaconda.sh -q && \
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
