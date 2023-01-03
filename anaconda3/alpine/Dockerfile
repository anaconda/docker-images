FROM frolvlad/alpine-glibc:alpine-3.17

LABEL maintainer="Anaconda, Inc"
ENV ANACONDA_VERSION 2021.11
ENV SHA256SUM=fedf9e340039557f7b5e8a8a86affa9d299f5e9820144bd7b92ae9f7ee08ac60

# Create non-root user, install dependencies, install Anaconda
# hadolint ignore=DL3018
RUN apk add -q --no-cache bash procps && \
    addgroup -S anaconda && \
    adduser -D -u 10151 anaconda -G anaconda && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh -O anaconda.sh && \
    echo "${SHA256SUM}  anaconda.sh" > anaconda.sha256 && \
    if ! sha256sum -cs anaconda.sha256; then exit 1; fi && \
    mkdir -p /opt && \
    sh ./anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh anaconda.sha256 && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    chown -R anaconda /opt && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate base" >> ~/.bashrc && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

USER  10151
CMD ["/bin/bash"]
