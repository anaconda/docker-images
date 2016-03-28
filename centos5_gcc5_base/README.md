# centos5_gcc52_base

Docker image (CentOS 5.11) with GCC 5.2, Binutils 2.26.

Libraries built with this docker container should be compatible with most Linux
distributions. Additionally, GCC5.2 allows compilation of C++11 and C++14 code.

This image is extremely limited. It is meant as a base layer for other tools
that utilize the compiler.

GCC in this image is compiled to output code with the C++11 ABI.  If you want
the C++98 (GCC4) ABI, you need to set ```CXXFLAGS="${CXXFLAGS} -D_GLIBCXX_USE_CXX11_ABI=0"```

Docker Hub location: https://hub.docker.com/r/continuumio/centos5_gcc5_base/
