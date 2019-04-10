#!/bin/bash

function usage {
    echo -e "Usage: ./build_anaconda.sh -v version \n"
    exit 1
}

while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -v|--version)
    VERSION="$2"
    shift
    shift
    ;;
    *)
    usage
    exit 0
    shift
    ;;
esac
done

cd ..

echo "ANACONDA ALPINE"

pushd anaconda/alpine
docker build . -t continuumio/anaconda:$VERSION-alpine
popd

echo "ANACONDA DEBIAN"

pushd anaconda/debian
docker build . -t continuumio/anaconda:$VERSION -t continuumio/anaconda:latest
popd

echo "ANACONDA3 ALPINE"

pushd anaconda3/alpine
docker build . -t continuumio/anaconda3:$VERSION-alpine
popd

echo "ANACONDA3 DEBIAN"

pushd anaconda3/debian
docker build . -t continuumio/anaconda3:$VERSION -t continuumio/anaconda3:latest
popd
