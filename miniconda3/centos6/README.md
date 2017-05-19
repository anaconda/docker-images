docker-miniconda2
-----

Docker container with a bootstrapped installation of conda and python 3.6 that is ready to use.

Conda and python 3.76are installed into the `/usr/local` prefix, with executables `/usr/local/bin/conda` and `/usr/local/bin/python`.

Anaconda is the leading open data science platform powered by Python. The open source version of Anaconda is a high performance distribution and includes over 100 of the most popular Python packages for data science. Additionally, it provides access to over 720 Python and R packages that can easily be installed using the conda dependency and environment manager, which is included in Anaconda.
Usage

You can download and run this image using the following commands:

`docker pull continuumio/miniconda3-centos`

`docker run -i -t continuumio/miniconda3-centos /bin/bash`
