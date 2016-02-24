#!/bin/bash

# Setup home environment
# newid and user are fed in from Docker.
useradd --disabled-password --gecos --uid=$("$NEWID" | cut -d ":" -f 1) $USER
mkdir -p /home/$USER && chown -R $USER: /home/$USER
chmod 777 /opt
adduser $USER sudo
echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

su -m $USER -c /opt/miniconda/env.sh

