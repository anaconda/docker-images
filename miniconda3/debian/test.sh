#!/bin/bash

set -ex

env
cat /proc/self/cgroup

conda create -y -n constructor constructor
conda run -n constructor constructor --help
