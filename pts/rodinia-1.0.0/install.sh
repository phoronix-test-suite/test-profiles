#!/bin/sh

tar -jxvf rodinia_2.2.tar.bz2

cd ~/rodinia_2.2/

cd ~/rodinia_2.2/openmp/cfd; 				make;
cd ~/rodinia_2.2/openmp/lavaMD;				make;
cd ~/rodinia_2.2/openmp/leukocyte;  			make;
cd ~/rodinia_2.2/openmp/streamcluster;			make;
echo \$? > ~/test-exit-status

cd ~/
echo "#!/bin/sh

export OMP_NUM_THREADS=\$NUM_CPU_CORES

case \$@ in
	\"OMP_CFD\")
		cd ~/rodinia_2.2/openmp/cfd
		./euler3d_cpu_double ../../data/cfd/missile.domn.0.2M > \$LOG_FILE
	;;
	\"OMP_LAVAMD\")
		cd ~/rodinia_2.2/openmp/lavaMD
		./lavaMD -cores \$NUM_CPU_CORES -boxes1d 48 > \$LOG_FILE
	;;
	\"OMP_LEUKOCYTE\")
		cd ~/rodinia_2.2/openmp/leukocyte
		./OpenMP/leukocyte 60 \$NUM_CPU_CORES ../../data/leukocyte/testfile.avi > \$LOG_FILE
	;;
	\"OMP_STREAMCLUSTER\")
		cd ~/rodinia_2.2/openmp/streamcluster
		./sc_omp 10 30 512 65536 65536 2000 none output.txt \$NUM_CPU_CORES > \$LOG_FILE
	;;
esac

echo \$? > ~/test-exit-status" > rodinia
chmod +x rodinia
