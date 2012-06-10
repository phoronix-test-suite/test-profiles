#!/bin/sh

tar -zxvf NPB3.3.tar.gz
tar -zxvf npb-omp-make-def-1.tar.gz
tar -jxvf npb-make-mpi-def-1.tar.bz2

mv -f make.def NPB3.3/NPB3.3-MPI/config/
mv -f make-mpi.def NPB3.3/NPB3.3-MPI/config/make.def
cd NPB3.3/NPB3.3-MPI/

make bt CLASS=A
make ep CLASS=B
make ep CLASS=C
make ep CLASS=D
make ft CLASS=A
make lu CLASS=A
make mg CLASS=B
make sp CLASS=A

echo \$? > ~/test-exit-status

cd ~
echo "#!/bin/sh
cd NPB3.3/NPB3.3-MPI/
export OMP_NUM_THREADS=\$NUM_CPU_CORES
mpiexec -np \$NUM_CPU_CORES ./bin/\$@.1 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > npb
chmod +x npb
