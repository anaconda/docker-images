# docker-miniconda

Docker container with a bootstrapped [miniconda][] installed and ready to use.

This installs ``conda`` and Python 2.7 into the ``/opt/conda`` environment
and ensures that the default user has that on their path.


Usage
-----
You can download and use this image by pulling it:

    docker pull continuumio/miniconda
    docker run -i -t continuumio/miniconda /bin/bash


[miniconda]: http://conda.pydata.org/miniconda.html
