#!/bin/sh

cd gcc-8.4.0
make distclean
./contrib/download_prerequisites
./configure --disable-multilib --enable-checking=release
