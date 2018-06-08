curl http://repo.anaconda.com/miniconda/Miniconda2-latest-Linux-x86_64.sh -o Miniconda.sh
/bin/bash Miniconda.sh -b -p /opt/miniconda
rm Miniconda.sh
/opt/miniconda/bin/conda config --set show_channel_urls True
/opt/miniconda/bin/conda update --yes --all
/opt/miniconda/bin/conda install --yes git conda-build curl anaconda-client
/opt/miniconda/bin/conda clean --tarballs --packages
