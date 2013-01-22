#!/bin/sh

tar -zxvf pb2.5driver.tgz
tar -zxvf pb2.5datasets_standard.tgz
tar -zxvf pb2.5benchmarks.tgz

mv datasets parboil/
mv benchmarks parboil/
mv parboil parboil-2.5-tree/

cd parboil-2.5-tree/
touch common/Makefile.conf # TODO: add OpenCL/CUDA support here to use more benchmarks...

./parboil compile cutcp omp_base
./parboil compile mri-q omp_base
./parboil compile mri-gridding omp_base
./parboil run stencil omp_base small
./parboil compile lbm omp_cpu
./parboil compile tpacf omp_base

echo $? > ~/test-exit-status
cd ~/

echo "#!/bin/sh
cd parboil-2.5-tree/
./parboil run \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > parboil
chmod +x parboil
