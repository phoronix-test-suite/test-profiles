#!/bin/bash
tar -xf oneDNN-3.6.tar.gz
cd oneDNN-3.6
mkdir build 
cd build 
CFLAGS="-O3 -march=native $CFLAGS" CXXFLAGS="-O3 -march=native $CXXFLAGS" cmake -DCMAKE_BUILD_TYPE=Release MKLDNN_ARCH_OPT_FLAGS="-O3 -march=native $CFLAGS" $CMAKE_OPTIONS ..
make -j $NUM_CPU_CORES
EXIT_STATUS=$?
if [ $EXIT_STATUS -ne 0 ]; then
	# For architectures not supporting -march=native compiler option...
	CFLAGS="-O3 $CFLAGS" CXXFLAGS="-O3 $CXXFLAGS" cmake -DCMAKE_BUILD_TYPE=Release MKLDNN_ARCH_OPT_FLAGS="-O3 $CFLAGS" $CMAKE_OPTIONS ..
	make -j $NUM_CPU_CORES
	EXIT_STATUS=$?
fi
echo $EXIT_STATUS > ~/install-exit-status
cd ~
echo "#!/bin/bash
export DNNL_CPU_RUNTIME=OMP
export OMP_PLACES=cores
export OMP_PROC_BIND=close
cd oneDNN-3.6/build/tests/benchdnn
./benchdnn \$4 --mode=p \$1 \$3 \$2 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > onednn
chmod +x onednn
