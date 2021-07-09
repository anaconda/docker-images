FROM debian:buster-slim

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:$PATH

# hadolint ignore=DL3008,DL4006
RUN set -x && \
    apt-get update --fix-missing && \
    apt-get install -y --no-install-recommends \
        bzip2 \
        ca-certificates \
        git \
        libglib2.0-0 \
        libxext6 \
        libsm6 \
        libxrender1 \
        mercurial \
        subversion \
        wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* && \
    UNAME_M="$(uname -m)" && \
    if [ "${UNAME_M}" = "x86_64" ]; then \
        ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh"; \
        SHA256SUM="2751ab3d678ff0277ae80f9e8a74f218cfc70fe9a9cdc7bb1c137d7e47e33d53"; \
    elif [ "${UNAME_M}" = "s390x" ]; then \
        ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-s390x.sh"; \
        SHA256SUM="a7d1a83279f439e7d8a6c53aa725552e195c0b96ae7e7fa63baefdf0118f7942"; \
    elif [ "${UNAME_M}" = "aarch64" ]; then \
        ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-aarch64.sh"; \
        SHA256SUM="3a3d5a61df5422f7c8c7816217b926ec7e200cc6d62967541adead8ec46d935d"; \
    elif [ "${UNAME_M}" = "ppc64le" ]; then \
        ANACONDA_URL="https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-ppc64le.sh"; \
        SHA256SUM="097064807a9adae3f91fc4c5852cd90df2b77fc96505929bb25bf558f1eef76f"; \
    fi && \
    wget "${ANACONDA_URL}" -O anaconda.sh -q && \
    echo "${SHA256SUM} anaconda.sh" | sha256sum --check --status && \
    /bin/bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

CMD [ "/bin/bash" ]
