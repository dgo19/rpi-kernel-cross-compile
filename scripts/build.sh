#!/bin/bash
GIT_REPO="https://github.com/raspberrypi/linux"
GIT_BRANCH="rpi-6.15.y"
COMPILE_NPROC="24"
KERNEL="kernel_2712"
KERNEL_CONFIG="bcm_2712-test"
MAKE_OPTS="ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-"
BUILD_PKGS="build-essential bc kmod cpio flex libncurses5-dev libelf-dev libssl-dev dwarves bison debhelper libc6-dev crossbuild-essential-arm64 git rsync libssl-dev python3:native"
set -e
apt update
apt -y install ${BUILD_PKGS}
cd /tmp/compile
git clone --depth=1 --branch ${GIT_BRANCH} ${GIT_REPO} src/
cd src
for PATCH in $(ls /tmp/compile/patch/*.diff); do patch -p1 < ${PATCH}; done
cp /tmp/compile/config/${KERNEL_CONFIG} .config
make ${MAKE_OPTS} oldconfig
make ${MAKE_OPTS} -j${COMPILE_NPROC} Image modules dtbs
make ${MAKE_OPTS} bindeb-pkg
cp -v /tmp/compile/*.deb /tmp/compile/out/
cp -v /tmp/compile/*.buildinfo /tmp/compile/out/
cp v /tmp/compile/*.changes /tmp/compile/out/
