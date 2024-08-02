#!/bin/sh
if which gmx_mpi >/dev/null 2>&1 ;
then
	echo 0 > ~/install-exit-status
else
	echo "ERROR: GROMACS gmx_mpi is not found on the system! This test profile needs a working gmx_mpi binary in the PATH."
	echo 2 > ~/install-exit-status
fi
tar -xf water_GMX50_bare.tar.gz
echo "#!/bin/sh
mpirun --allow-run-as-root -np \$NUM_CPU_PHYSICAL_CORES gmx_mpi grompp -f pme.mdp  -o bench.tpr
mpirun --allow-run-as-root -np \$NUM_CPU_PHYSICAL_CORES gmx_mpi mdrun -resethway -npme 0 -notunepme -noconfout -nsteps 1000 -v -s  bench.tpr" >  run-gromacs
chmod +x run-gromacs
echo "#!/bin/sh
unset OMP_NUM_THREADS
cd \$1
rm -f *bench.tpr*
\$HOME/run-gromacs > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
gmx_mpi --version | grep GROMACS | grep version > ~/pts-footnote > ~/pts-footnote" > gromacs
chmod +x gromacs
