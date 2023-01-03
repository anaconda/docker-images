FROM frolvlad/alpine-glibc:alpine-3.17

LABEL maintainer="Anaconda, Inc"
ENV ANACONDA_VERSION=2022.10
ENV SHA256SUM=e7ecbccbc197ebd7e1f211c59df2e37bc6959d081f2235d387e08c9026666acd

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
