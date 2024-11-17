#!/bin/sh
rm -rf eigen-3.4.0
tar -xf eigen-3.4.0.tar.bz2
mkdir eigen-3.4.0/build
cd eigen-3.4.0/build
cmake -DCMAKE_BUILD_TYPE=Release -DEIGEN_BUILD_DOC=ON ..
