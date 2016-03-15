# centos5_gcc52_base

Docker image (CentOS 5.11) with GCC 5.2, Binutils 2.26.

Libraries built with this docker container should be compatible with most Linux
distributions. Additionally, GCC5.2 allows compilation of C++11 and C++14 code.

This image is extremely limited. It is meant as a base layer for other tools
that utilize the compiler.

There are two installations of GCC 5.2 in this image: one for the
C++98-compatible ABI (GCC4-compatible), and the other for C++11 ABI
(GCC5-compatible). These are in /usr/local/gcc5_abi4 and /usr/local/gcc5_abi5,
respectively. Neither are on PATH, by default. You must manually add them before
using them, or specify full paths.
