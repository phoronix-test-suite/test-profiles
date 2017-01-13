#!/bin/sh
cd memcached-1.4.34
./memcached -d
echo $! > ~/memcached-pid
sleep 3
