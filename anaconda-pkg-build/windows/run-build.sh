#!/bin/bash

# needed for dirname for activate below
PATH=$PATH:/usr/bin

# get working directory
WORKDIR="$1"
shift 1

# save commands and reset them otherwise activate will assume arguments are for it
COMMAND=("$@")
set --

# shellcheck source=/dev/null
source /c/Users/Administrator/miniconda3/Scripts/activate

# change to working directory
cd "$WORKDIR"

# execute command
${COMMAND[@]}