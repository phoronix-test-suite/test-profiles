#!/bin/sh

# Based on original script by Lars Vingli Odsaeter

rm -rf *

# Download source from github
git clone git://github.com/OPM/opm-parser.git
git clone git://github.com/OPM/opm-common.git
git clone git://github.com/OPM/opm-core.git
git clone git://github.com/OPM/opm-material.git
git clone git://github.com/OPM/opm-porsol.git
git clone git://github.com/OPM/opm-upscaling.git
git clone git://github.com/OPM/dune-cornerpoint.git
git clone git://github.com/OPM/opm-autodiff.git
git clone git://github.com/OPM/opm-polymer.git
git clone git://github.com/Ensembles/ert.git

# Optional, but needed for integration tests of
# reservoir simulator
git clone git://github.com/OPM/opm-data.git

# Build ERT
mkdir ert/build
cd ert/build
cmake ../devel
make -j $NUM_CPU_CORES
cd $HOME

# Set cmake variables to file opts.cmake
echo "
set(ERT_ROOT          \"$HOME/ert\" CACHE STRING \"Path to ERT\")
" > opts.cmake

if [ -x /usr/bin/cmake ]
then
	CMAKE=cmake
elif [ -x /usr/bin/cmake28 ]
then
	# On some RHEL 6 systems they seem to have cmake28 but not cmake
	CMAKE=cmake28
else
	# Fallback
	CMAKE=cmake
fi

# Build all modules
mkdir opm-common/build
cd opm-common/build
$CMAKE -C $HOME/opts.cmake  ..
nice make -j $NUM_CPU_CORES
cd $HOME


mkdir opm-parser/build
cd opm-parser/build
$CMAKE -C $HOME/opts.cmake  ..
nice make -j $NUM_CPU_CORES
cd $HOME

mkdir opm-material/build
cd opm-material/build
$CMAKE -C $HOME/opts.cmake  ..
nice make -j $NUM_CPU_CORES
cd $HOME

mkdir opm-core/build
cd opm-core/build
$CMAKE -C $HOME/opts.cmake ..
nice make -j $NUM_CPU_CORES
cd $HOME
 
mkdir dune-cornerpoint/build
cd dune-cornerpoint/build
$CMAKE -C $HOME/opts.cmake  ..
nice make -j $NUM_CPU_CORES
cd $HOME
 
mkdir opm-porsol/build
cd opm-porsol/build
$CMAKE -C $HOME/opts.cmake  ..
nice make -j $NUM_CPU_CORES
cd $HOME
 
mkdir opm-upscaling/build
cd opm-upscaling/build
$CMAKE -C $HOME/opts.cmake  ..
nice make -j $NUM_CPU_CORES
cd $HOME

# mkdir opm-autodiff/build
# cd opm-autodiff/build
# $CMAKE -C $HOME/opts.cmake  ..
# nice make -j $NUM_CPU_CORES
# echo $? > $HOME/install-exit-status
# cd $HOME

cd opm-upscaling/build
make upscale_relperm_benchmark
cd $HOME

######################################################
# Run benchmark
######################################################

echo "#!/bin/sh

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
# echo \$? > ~/test-exit-status" > opm-git
chmod +x opm-git
