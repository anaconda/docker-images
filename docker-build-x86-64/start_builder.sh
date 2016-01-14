#!/usr/bin/env bash
user=$(id -u -n)
home=$(eval echo "~${user}")
id=$(docker run -ti -d -e USER=$user \
       -v $home/.ssh:/home/dev/.ssh:ro \
       msarahan/conda_builder_linux:latest \
       /hbb_exe/activate-exec /bin/bash)
docker cp $home/.gitconfig $id:/home/dev/.gitconfig
docker attach $id
