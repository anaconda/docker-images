FROM debian:bullseye-slim

LABEL maintainer="Anaconda, Inc"

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# hadolint ignore=DL3008
RUN apt-get update -q && \
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
        subversion \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

ENV PATH /opt/conda/bin:$PATH

CMD [ "/bin/bash" ]

# Leave these args here to better use the Docker build cache
# renovate: datasource=custom.miniconda
ARG INSTALLER_URL_LINUX64="https://repo.anaconda.com/miniconda/Miniconda3-py311_24.1.2-0-Linux-x86_64.sh"
ARG SHA256SUM_LINUX64="3f2e5498e550a6437f15d9cc8020d52742d0ba70976ee8fce4f0daefa3992d2e"
# renovate: datasource=custom.miniconda
ARG INSTALLER_URL_S390X="https://repo.anaconda.com/miniconda/Miniconda3-py311_24.1.2-0-Linux-s390x.sh"
ARG SHA256SUM_S390X="04586c734987a39114b81384014c2cfa89360c518371b6fa249d3062efca27fe"
# renovate: datasource=custom.miniconda
ARG INSTALLER_URL_AARCH64="https://repo.anaconda.com/miniconda/Miniconda3-py311_24.1.2-0-Linux-aarch64.sh"
ARG SHA256SUM_AARCH64="1e046ef2d9d47289db2491f103c81b0b4baf943a9234ac59bd5bca076c881d98"

RUN set -x && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        INSTALLER_URL="${INSTALLER_URL_LINUX64}"; \
        SHA256SUM="${SHA256SUM_LINUX64}"; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
        INSTALLER_URL="${INSTALLER_URL_S390X}"; \
        SHA256SUM="${SHA256SUM_S390X}"; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
        INSTALLER_URL="${INSTALLER_URL_AARCH64}"; \
        SHA256SUM="${SHA256SUM_AARCH64}"; \
    fi && \
    wget "${INSTALLER_URL}" -O miniconda.sh -q && \
    echo "${SHA256SUM} miniconda.sh" > shasum && \
    sha256sum --check --status shasum && \
    mkdir -p /opt && \
    bash miniconda.sh -b -p /opt/conda && \
    rm miniconda.sh shasum && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy
