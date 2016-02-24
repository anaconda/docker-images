#!/usr/bin/env bash
user=$(id -u -n)
home=$(eval echo "~${user}")

ssh_vol=""
if [ -d "$home/.ssh" ]; then
    ssh_vol="-v $home/.ssh:/home/dev/.ssh:ro"
    NEW_ID=$(stat -c "%u:%g" ~/.ssh) 
fi

gitconfig_vol=""
if [ -e $home/.gitconfig ]; then
    gitconfig_vol="-v $home/.gitconfig:/home/dev/.gitconfig:ro"
    NEW_ID=$(stat -c "%u:%g" ~/.gitconfig)
fi

docker run -ti -e USER=$user -e NEW_ID=$NEW_ID \
       $ssh_vol \
       $gitconfig_vol \
       msarahan/conda_builder_linux:latest \
       bash -c '/home/dev/startup.sh;bash'
