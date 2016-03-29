#!/usr/bin/env bash
bash $(dirname "${BASH_SOURCE[0]}")/docker_wrapper.sh -e "ABI=5" -e "ARCH=32" $@
