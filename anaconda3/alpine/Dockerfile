FROM frolvlad/alpine-glibc:alpine-3.17

LABEL maintainer="Anaconda, Inc"
ENV ANACONDA_VERSION 2021.05
ENV ANACONDA_MD5 25e3ebae8905450ddac0f5c93f89c467

# Create non-root user, install dependencies, install Anaconda
RUN addgroup -S anaconda && \
    adduser -D -u 10151 anaconda -G anaconda && \
    wget --quiet https://repo.continuum.io/archive/Anaconda3-$ANACONDA_VERSION-Linux-x86_64.sh -O anaconda.sh && \
    echo "${ANACONDA_MD5}  anaconda.sh" > anaconda.md5 && \
    if ! md5sum -s -c anaconda.md5; then exit 1; fi && \
    mkdir -p /opt && \
    sh ./anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh anaconda.md5 && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    chown -R anaconda /opt && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/anaconda/.profile && \
    echo "conda activate base" >> /home/anaconda/.profile && \
    find /opt/conda/ -follow -type f -name '*.a' -delete && \
    find /opt/conda/ -follow -type f -name '*.js.map' -delete && \
    /opt/conda/bin/conda clean -afy

USER  10151
ENV PATH "/bin:/sbin:/usr/bin"

CMD [ "sh", "--login", "-i" ]
