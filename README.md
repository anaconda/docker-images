# docker-miniconda

Docker container with a bootstrapped [miniconda][] installed and ready to use.

This installs ``conda`` and Python 3.4 into the ``/opt/anaconda`` environment
and ensures that the default user has that on their path.


Usage
-----
You can download and use this image by pulling it:

    docker pull tswicegood/miniconda
    docker run -i -t tswicegood/miniconda:3.5.5 /bin/bash


[miniconda]: http://conda.pydata.org/miniconda.html
