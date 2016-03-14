# docker-build-x86_64

Docker container (CentOS 5.11) with GCC 5.2, Binutils 2.26, and a bootstrapped [miniconda](http://conda.pydata.org/miniconda.html) installed and ready to use.

Libraries built with this docker container should be compatible with most Linux distributions.  Additionally, GCC5.2 allows compilation of C++11 and C++14 code.

Usage
-----

A helper script for running is provided that mounts your .ssh folder (for passwordless SSH) and ~/.gitconfig file in the container.  To run this, download the start_builder.sh script and run it from your Docker terminal.  On Windws and Mac with Docker Toolbox, this is your Docker Quickstart terminal.

Once that starts, it doesn't always immediately show the shell prompt.  We're working on that.  Hit enter, and you'll see it.  Something like this:

    [dev@da2f4a3e941b ~]$

Once you're at a prompt, you have quick access to git, conda, and conda-build, all installed and on PATH.  Additionally, a few aliases are set up by default:

  - **clone_recipes**: clone the conda recipes repository from https://github.com/conda/conda-recipes
  - **clone_anaconda**: clone the conda recipes repository from https://github.com/continuumIO/anaconda (This is a Continuum private repo.  Checking this out requires your ssh keys to be set up properly.)
  - **anaconda_setup**: clone the conda recipes repository from https://github.com/continuumIO/anaconda and run ```python setup.py develop``` to install the build system's commands

NOTES
-----

 - GCC is compiled with the ```--with-default-libstdcxx-abi=gcc4-compatible``` flag - this is under evaluation as to what the best approach for maximum compatibility might be.  We welcome feedback on this issue.
