#!/bin/sh

rm -rf linux-4.3/
tar -xf linux-4.3.tar.gz

cd linux-4.3/
make defconfig
make clean
