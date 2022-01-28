#!/bin/sh

tar -zxvf graph500-graph500-3.0.0.tar.gz
cd graph500-graph500-3.0.0/src

# Needed for GCC 10+ compiler support nicely building
sed -i 's/CFLAGS = /CFLAGS = -fcommon /g' Makefile

make
echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd graph500-graph500-3.0.0/src
mpirun --allow-run-as-root -np \$NUM_CPU_PHYSICAL_CORES ./graph500_reference_bfs_sssp \$1 > \$LOG_FILE
echo \$? > ~/test-exit-status" > graph500
chmod +x graph500
