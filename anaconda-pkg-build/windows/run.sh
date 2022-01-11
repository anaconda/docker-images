#!/bin/bash

set -o nounset -o pipefail -o errexit

#COMMAND=("$@")
#${COMMAND[@]}
#exit

# needed for dirname for activate below
PATH=$PATH:/usr/bin

# save commands and reset them otherwise activate will assume arguments are for it
COMMAND=("$@")
set --

# shellcheck source=/dev/null
source /c/Users/Administrator/miniconda3/Scripts/activate

# execute command
${COMMAND[@]}