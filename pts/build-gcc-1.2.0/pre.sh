#!/bin/sh

rm -rf gcc-8.4.0
tar -xf gcc-8.4.0.tar.gz

cd gcc-8.4.0
./contrib/download_prerequisites
./configure --disable-multilib --enable-checking=release
make defconfig
make clean
