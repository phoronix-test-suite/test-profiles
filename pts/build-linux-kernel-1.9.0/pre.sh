#!/bin/sh

rm -rf linux-4.17/
tar -xf linux-4.17.tar.gz

cd linux-4.17/
make defconfig
make clean
