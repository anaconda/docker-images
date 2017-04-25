FROM continuumio/miniconda3

MAINTAINER Michael Sarahan <msarahan@continuum.io>

RUN conda update -qy --all && conda install -qy -c conda-canary -c msarahan conda-build conda-concourse-ci && conda clean -pty
RUN mkdir -p bin && curl -L https://github.com/concourse/concourse/releases/download/v2.7.3/fly_linux_amd64 -o bin/fly && chmod +x bin/fly
RUN echo "export PATH=$PATH:~/bin" >> ~/.bashrc
RUN echo "add_pip_as_python_dependency: False" >> ~/.condarc

ENTRYPOINT [ "/usr/bin/tini", "--" ]
CMD [ "/bin/bash" ]
