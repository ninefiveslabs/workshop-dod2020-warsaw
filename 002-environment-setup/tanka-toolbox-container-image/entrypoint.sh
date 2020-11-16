#!/bin/bash

function help() {
    echo "${1} is missing."
    echo 'Run me like this:'
    echo 'docker run --rm -ti -v /var/run/docker.sock:/var/run/docker.sock --net=host ninefiveslabs/tanka-toolbox'
    exit 1
}

function check() {
    [ -e "$1" ] || help "$1"
}

check /var/run/docker.sock
check /usr/local/bin/docker
echo "kind create cluster"
bash
