#!/usr/bin/env bash

set -o errtrace -o nounset -o pipefail -o errexit -x

env | sort

DEFAULT_BUILD_ARGS=(--suppress-variables --error-overlinking --error-overdepending)
declare -a BUILD_ARGS=()
for arg do
    shift
    if [[ "${arg}" == -build-args=* ]]; then
        IFS=',' read -r -a BUILD_ARGS <<< "${arg//-build-args=}"
        continue
    fi
    set -- "$@" "${arg}"
done

if [ "${#BUILD_ARGS[@]}" -eq 0 ]; then
    BUILD_ARGS="${DEFAULT_BUILD_ARGS[@]}"
fi

conda config --system --add default_channels https://repo.anaconda.com/pkgs/main
conda config --system --add default_channels https://repo.anaconda.com/pkgs/r

# read + set -channels=*
# ...
# conda config --system --add channels c3i_test2

conda info -a

conda build "${BUILD_ARGS[@]}" /feedstock -m /feedstock/.abs/conda_build_config.yaml --output-folder /upload

chmod -R 777 /upload
