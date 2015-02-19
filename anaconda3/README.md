# docker-anaconda

Docker container with a bootstrapped [anaconda][] installed and ready to use.

This installs whole anaconda python distribution (with native python in 3.4 version) into the ``/opt/conda`` environment
and ensures that the default user has ``conda`` tool on their path.


Usage
-----
You can download and use this image by pulling it:

    docker pull continuumio/anaconda3
    docker run -i -t continuumio/anaconda3 /bin/bash


[anaconda]: http://docs.continuum.io/anaconda/index.html
