#!/bin/sh
MEMCACHED_PID=`cat ~/memcached-pid`
kill $MEMCACHED_PID
sleep 3
