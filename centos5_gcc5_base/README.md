# centos5_gcc52_base

Docker image (CentOS 5.11) with GCC 5.2, Binutils 2.26.

Libraries built with this docker container should be compatible with most Linux distributions.  Additionally, GCC5.2 allows compilation of C++11 and C++14 code.

Note that GCC is compiled with the ```--with-default-libstdcxx-abi=gcc4-compatible``` flag - this is under evaluation as to what the best approach for maximum compatibility might be.  We welcome feedback on this issue.
