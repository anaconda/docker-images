#!/bin/bash -x
#
# This script allows you to build (linux) conda recipes with the only requirement that you have docker installed
#
# Examples
# --------
#
#   $ mkdir /tmp/conda_pkg
#   $ ./conda_build_in_docker.sh ~/vc/conda-recipes/jinja2 /tmp/conda_pkg
#   $ ls /tmp/conda_pkg
#   jinja2-2.7.3-py27_0.tar.bz2  repodata.json  repodata.json.bz2
#
# You can also run the script with custom channels:
#
#   $ ./conda_build_in_docker.sh ~/vc/conda-recipes/jinja2 /tmp/conda_pkg stuarteberg,asmeurer
#
# 
# Notes
# -----
# Your user need to be in the docker group (docker is not invoked with "sudo").
# To add your user to the docker group you may write:
#
#  $ sudo adduser $(whoami) docker
#
# TODO
# ----
# Provide an mechanism to re-use package cache between
# invocations. Could be a 4th positional argument:
# and then -v $ABS_PKG_CACHE:/opt/conda/pkgs

ABS_RECIPE_PATH=$(unset CDPATH && cd "$1" && echo $PWD)
ABS_OUTPUT_PATH=$(unset CDPATH && cd "$2" && echo $PWD)
CONDA_ENVS=""
if [ ! -z $CONDA_PY ]; then
    CONDA_ENVS="$CONDA_ENVS -e CONDA_PY"
fi
if [ ! -z $CONDA_NPY ]; then
    CONDA_ENVS="$CONDA_ENVS -e CONDA_NPY"
fi
# Since docker run as uid 0 by default we export our uid and gid and set ownership
# of files in our volume /output before exiting the container.
cat <<'EOF' | docker run --rm $CONDA_ENVS -e CONDA_CHANNELS=$3 -e HOST_UID=$(id -u) -e HOST_GID=$(id -g) -v $ABS_RECIPE_PATH:/recipe:ro -v $ABS_OUTPUT_PATH:/output -i continuumio/anaconda bash -x
IFS=',' read -a array <<< "$CONDA_CHANNELS"
for element in "${array[@]}"
do
    conda config --add channels "$element"
done
conda info
conda config --set always_yes true
conda install patchelf
conda update -n root conda-build
conda build /recipe
cp `conda info --root`/conda-bld/linux-64/* /output
chown $HOST_GID:$HOST_UID /output/*
EOF
