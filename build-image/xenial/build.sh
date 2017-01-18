#!/bin/bash

set -euo pipefail
buildnumber=$1

docker build -t scribe-builder-xenial .

mkdir -p output
rm -rf output/*
docker run -it --volume $(pwd)/output:/output scribe-builder-xenial ./build.sh $buildnumber
