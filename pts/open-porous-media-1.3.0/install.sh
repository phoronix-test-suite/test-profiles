#!/bin/sh

# Based on original script by Lars Vingli Odsaeter

tar -xjvf opm-20131126.tar.bz2
cd opm-20131126

modules='opm-core opm-material dune-cornerpoint opm-porsol opm-upscaling opm-benchmarks'

for module in ${modules}; do
   mkdir ${module}/build
   cd ${module}/build
   cmake -DUSE_MPI=ON ../
   nice make -j 4
   echo $? > ~/install-exit-status
   cd ../../
done
# You may want to edit the config.opts file
cd ~

######################################################
# Run benchmark
######################################################

echo "#!/bin/sh
cd opm-20131126

if [ \"X\$OMP_NUM_THREADS\" = \"X\" ]
then
	OMP_NUM_THREADS=\$NUM_CPU_CORES
fi

if [ ! \"X\$HOSTFILE\" = \"X\" ] && [ -f \$HOSTFILE ]
then
	\$HOSTFILE=\"--hostfile \$HOSTFILE\"
elif [ -f /etc/hostfile ]
then
	\$HOSTFILE=\"--hostfile /etc/hostfile\"
else
	\$HOSTFILE=\"\"
fi

nice mpirun -np \$OMP_NUM_THREADS \$HOSTFILE \$@ > \$LOG_FILE 2>&1
# echo \$? > ~/test-exit-status" > open-porous-media
chmod +x open-porous-media
