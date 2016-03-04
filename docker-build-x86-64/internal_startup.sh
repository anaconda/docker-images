#!/bin/bash

if [[ -z "${ABI}" ]]; then
    echo "WARNING: No ABI default set.  Falling back to compatibility mode with GCC 4."
    export ABI=4
fi

# Setup home environment

export PATH=/opt/miniconda/bin:/usr/local/gcc5_abi${ABI}/bin:$PATH
export LD_LIBRARY_PATH=/opt/miniconda/lib:/usr/local/gcc5_abi${ABI}/lib:$LD_LIBRARY_PATH
export INCLUDE=/opt/miniconda/include:/usr/local/gcc5_abi${ABI}/include:$INCLUDE

echo "alias clone_recipes='git clone https://github.com/conda/conda-recipes'" >> ~/.bashrc
# Continuum internal build system (private repo, requires on-site or VPN, may require Docker VM restart if network settings change)
echo "alias clone_anaconda='git clone git@github.com:continuumIO/anaconda'" >> ~/.bashrc
echo "alias anaconda_setup='clone_anaconda && cd anaconda && git checkout use_hbb && python setup.py develop && cd .. && mkdir aroot'" >> ~/.bashrc

echo
echo "Welcome to the conda-builder image, brought to you by Continuum Analytics."
echo
echo "Binaries produced with this image should be compatible with any Linux OS"
echo "that is at least CentOS 5 or newer (Glibc lower bound), and anything "
echo "that uses G++ 5.2 or older (libstdc++ upper bound)"
echo
echo "   GCC is: $(gcc --version | head -1)"
echo "   Default C++ ABI: ${ABI} (C++ $([ "${ABI}" == "4" ] && echo "98" || echo "11"))"
echo "   GLIBC is: $(getconf GNU_LIBC_VERSION)"
echo "   Native arch is x64.  To build for 32-bit, set CONDA_FORCE_32BIT=1, or outside of conda-build, CFLAGS=\"-m32\""
echo "   ld/binutils is: $(ld --version | head -1)"
echo
echo "   The dev user has passwordless sudo access for yum and such."
echo "   miniconda (2.7) is installed at /opt/miniconda."
echo "   git is also available."

if [ -f "/home/dev/.gitconfig" ]; then
    echo "   Your .gitconfig has been imported."
fi

# jumping through hoops for file ownership - we can't have the owner be
#    the native linux owner, and we also can't have permissions too wide open,
#    or ssh complains.
if [ -f /id_rsa ]; then
    mkdir -p .ssh
    sudo cp /id_rsa .ssh/
    chmod 700 .ssh
    sudo chown dev: .ssh/id_rsa
    sudo chmod 600 .ssh/id_rsa
    echo -e "Host github.com\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
    echo -e "Host bremen\n\tStrictHostKeyChecking no\n" >> ~/.ssh/config
    echo "   Your ssh private key has been imported for passwordless ssh."
fi

echo

echo "Helpful aliases:"
echo "    clone_recipes: clones the conda/conda-recipes repo from Github"
echo "    clone_anaconda: clones the continuumIO/anaconda (private) repo from Github"
echo "    anaconda_setup: clones anaconda repo and sets up continuum internal build system."

echo

bash "$@"
