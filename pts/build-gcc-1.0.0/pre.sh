#!/bin/sh

rm -rf gcc-7.2.0
tar -xf gcc-7.2.0.tar.gz

cd gcc-7.2.0
./contrib/download_prerequisites
./configure --disable-multilib --enable-checking=release
make defconfig
make clean
