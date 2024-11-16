#!/bin/sh
tar -xf nwchem-7.2.3-release.revision-d690e065-srconly.2024-08-27.tar.bz2
cd nwchem-7.2.3/src/
echo "NWCHEM_LONG_PATHS = Y" >> config/makefile.h
NWCHEM_TOP=$HOME/nwchem-7.2.3 BLAS_SIZE=8 NWCHEM_LONG_PATHS=Y NWCHEM_TARGET=LINUX64 USE_MPI=y BLASOPT="-lopenblas -lpthread -lrt" LAPACK_LIB="-llapack" NWCHEM_MODULES="all" make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
cat>nwchem<<EOT
#!/bin/sh
export OMP_NUM_THREADS=1
mpirun --allow-run-as-root -np \$NUM_CPU_PHYSICAL_CORES \$HOME/nwchem-7.2.3/bin/LINUX64/nwchem \$HOME/\$1 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
EOT
chmod +x nwchem

