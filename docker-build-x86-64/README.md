# docker-build-x86_64

Docker container (CentOS 5) with [Holy Build Box](http://phusion.github.io/holy-build-box/) customizations and a bootstrapped [miniconda](http://conda.pydata.org/miniconda.html) installed and ready to use.

Libraries built with this docker container should be compatible with most Linux distributions.  Additionally, GCC4.8 from Holy Build Box allows compilation of C++11 code.

Usage
-----

A helper script for running is provided that mounts your .ssh folder (for passwordless SSH) and ~/.gitconfig file in the container.  To run this, download the start_builder.sh script and run it from your Docker terminal.
