#!/bin/sh

tar -jxvf renderer-2.2z.tar.bz2

cd renderer-2.2z/
./configure
make
echo $? > ~/install-exit-status
cd ~

echo "#!/bin/sh
cd renderer-2.2z/3D-Objects
OMP_NUM_THREADS=\$NUM_CPU_CORES ../src/renderer \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ttsiod-renderer
chmod +x ttsiod-renderer
