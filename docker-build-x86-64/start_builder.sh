#!/usr/bin/env bash
user=$(id -u -n)
home=$(eval echo "~${user}")

ssh_vol=""
if [ -e $home/.ssh/id_rsa ]; then
   ssh_vol="-v $home/.ssh/id_rsa:/id_rsa:ro"
fi

gitconfig_vol=""
if [ -e $home/.gitconfig ]; then
    gitconfig_vol="-v $home/.gitconfig:/home/dev/.gitconfig:ro"
fi

# TODO: allow users to pass in their own docker run options here:
#    - additional mounts
#    - use --rm or not
#    - run in detached mode?

docker run -ti --rm -e USER=$user \
       $ssh_vol \
       $gitconfig_vol \
       msarahan/conda_builder_linux:latest \
       bash -c '/opt/share/startup.sh "$@"'
