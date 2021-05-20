#!/bin/bash -e

# Restore old resolution
#
xrandr --size $( cat /tmp/old_resolution )
rm /tmp/old_resolution
