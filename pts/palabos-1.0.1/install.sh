#!/bin/sh
tar -xf palabos-1f0b171dfacfa1aeb943c3a3318e52b0c25ed842.tar.gz
cd palabos-1f0b171dfacfa1aeb943c3a3318e52b0c25ed842/build
cmake -DCMAKE_BUILD_TYPE=Release -DENABLE_MPI=ON -DBUILD_HDF5=ON ..
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd palabos-1f0b171dfacfa1aeb943c3a3318e52b0c25ed842/build
OMP_NUM_THREADS=\$CPU_THREADS_PER_CORE mpirun --allow-run-as-root -np \$NUM_CPU_PHYSICAL_CORES ../examples/benchmarks/cavity3d/cavity3d_benchmark \$@ > \$LOG_FILE
echo \$? > ~/test-exit-status" > palabos
chmod +x palabos
