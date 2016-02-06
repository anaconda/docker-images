# docker-build-x86_64

Docker container (CentOS 5.11) with GCC 5.2, Binutils 2.26, and a bootstrapped [miniconda](http://conda.pydata.org/miniconda.html) installed and ready to use.

Libraries built with this docker container should be compatible with most Linux distributions.  Additionally, GCC5.2 allows compilation of C++11 and C++14 code.

Usage
-----

A helper script for running is provided that mounts your .ssh folder (for passwordless SSH) and ~/.gitconfig file in the container.  To run this, download the start_builder.sh script and run it from your Docker terminal.

note that GCC is compiled with the ```--with-default-libstdcxx-abi=gcc4-compatible``` flag - this is under evaluation as to what the best approach for maximum compatibility might be.  We welcome feedback on this issue.
