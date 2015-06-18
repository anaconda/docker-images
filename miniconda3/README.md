# docker-miniconda

Docker container with a bootstrapped [miniconda3](http://conda.pydata.org/miniconda.html) installed and ready to use.

This installs ``conda`` and Python 3.4 into the ``/opt/conda`` environment
and ensures that the default user has that on their path.


Usage
-----
You can download and use this image by pulling it:

    docker pull continuumio/miniconda3
    docker run -i -t continuumio/miniconda3 /bin/bash


[miniconda]: http://conda.pydata.org/miniconda.html
