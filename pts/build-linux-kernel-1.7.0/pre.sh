#!/bin/sh

rm -rf linux-4.9/
tar -xf linux-4.9.tar.gz

cd linux-4.9/
make defconfig
make clean
