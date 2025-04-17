#!/bin/bash
IMAGE="docker.io/library/debian:bookworm"
BASEDIR=${PWD}
podman run --rm -v ${BASEDIR}/out:/tmp/compile/out -v ${BASEDIR}/scripts:/tmp/compile/scripts -v ${BASEDIR}/config:/tmp/compile/config -v ${BASEDIR}/patch:/tmp/compile/patch ${IMAGE} /tmp/compile/scripts/build.sh
