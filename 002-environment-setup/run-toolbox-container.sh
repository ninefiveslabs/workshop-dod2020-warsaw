#!/bin/sh
mydir=$(realpath $(dirname "$0"))
docker run --rm -ti -w /workshop-tanka -v "${mydir}/..:/workshop-tanka" -v /var/run/docker.sock:/var/run/docker.sock --net=host ninefiveslabs/tanka-toolbox
