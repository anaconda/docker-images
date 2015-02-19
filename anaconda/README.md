# docker-anaconda

Docker container with a bootstrapped [anaconda][] installed and ready to use.

This installs whole anaconda python distribution (with native python in 2.7 version) into the ``/opt/conda`` environment
and ensures that the default user has ``conda`` tool on their path.


Usage
-----
You can download and use this image by pulling it:

    docker pull continuumio/anaconda
    docker run -i -t continuumio/anaconda /bin/bash


[anaconda]: http://docs.continuum.io/anaconda/index.html
