#!/bin/bash

set -ex

conda create -y -n constructor constructor
conda run -n constructor constructor --help
