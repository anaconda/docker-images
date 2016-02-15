#!/usr/bin/env bash
user=$(id -u -n)
home=$(eval echo "~${user}")

ssh_vol=""
if [ -d "$home/.ssh" ]; then
   ssh_vol="-v $home/.ssh:/home/dev/.ssh:ro"
fi

gitconfig_vol=""
if [ -e $home/.gitconfig ]; then
    gitconfig_vol="-v $home/.gitconfig:/home/dev/.gitconfig:ro"
fi

docker run -ti -e USER=$user \
       $ssh_vol \
       $gitconfig_vol \
       msarahan/conda_builder_linux:latest \
       bash -c 'echo "Welcome to the conda-builder image.  \
clone_recipes will clone the conda-recipes repo.";bash'
