#!/bin/sh

cd gcc-7.2.0
make distclean
./configure --disable-multilib --enable-checking=release
