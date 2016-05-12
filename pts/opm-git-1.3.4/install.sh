#!/bin/sh

# Clean up in case of any Git issues
rm -rf opm-data
rm -rf opm-parser
rm -rf opm-output
rm -rf opm-common
rm -rf opm-core
rm -rf opm-material
rm -rf opm-porsol
rm -rf opm-upscaling
rm -rf opm-grid
rm -rf opm-simulators
rm -rf opm-polymer
rm -rf ert

# Download source from github
FOOTNOTE_INFO="Build Time `date`; "
git clone git://github.com/OPM/opm-data.git
git clone git://github.com/OPM/opm-parser.git
git clone git://github.com/OPM/opm-output.git
git clone git://github.com/OPM/opm-common.git
git clone git://github.com/OPM/opm-core.git
git clone git://github.com/OPM/opm-material.git
git clone git://github.com/OPM/opm-porsol.git
git clone git://github.com/OPM/opm-upscaling.git
git clone git://github.com/OPM/opm-grid.git
git clone git://github.com/OPM/opm-simulators.git
git clone git://github.com/OPM/opm-polymer.git
git clone git://github.com/Ensembles/ert.git

# Build Scotch
tar -xvf scotch_6.0.4.tar.gz
cd scotch_6.0.4/src
ln -s Make.inc/Makefile.inc.x86-64_pc_linux2 Makefile.inc
make scotch
make CCD=mpicc ptscotch
mkdir ~/opt
make prefix=$HOME/opt install
cp -f ../include/*.h ~/opt/include/

cd ~

# Build Zoltan
tar -xvf zoltan_distrib_v3.8.tar.gz
mkdir zoltan-build
cd zoltan-build
../Zoltan_v3.8/configure --prefix=$HOME/opt --with-scotch --with-scotch-incdir=$HOME/opt/include --with-scotch-libdir=$HOME/opt/lib
make LIBS="-lscotch -lptscotcherrexit"

# Delete lines having bad perl code no longer supported
sed -i.bak -e '12,16d' ../Zoltan_v3.8/config/generate-makeoptions.pl 

make install
cd ~

# Build ERT
mkdir ert/build
cd ert/build
cmake ../devel
make -j $NUM_CPU_CORES
cd $HOME

# Set cmake variables to file opts.cmake
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

CMAKE_EXTRAS="-DERT_ROOT=$HOME/ert -DPTSCOTCH_ROOT=$HOME/opt -DZOLTAN_ROOT=$HOME/opt -DPARMETIS_ROOT=$HOME/opt -DUSE_MPI=ON"

# Build all modules
mkdir opm-common/build
cd opm-common/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
cd $HOME


mkdir opm-parser/build
cd opm-parser/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
cd $HOME

mkdir opm-material/build
cd opm-material/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
cd $HOME

mkdir opm-core/build
cd opm-core/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
cd $HOME
 
mkdir opm-grid/build
cd opm-grid/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
cd $HOME
 
mkdir opm-porsol/build
cd opm-porsol/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
cd $HOME

mkdir opm-output/build
cd opm-output/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
make install
cd $HOME

cp -va opm-output/opm/output opm-upscaling/opm
mkdir opm-upscaling/build
cd opm-upscaling/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
cd $HOME

mkdir opm-simulators/build
cd opm-simulators/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
echo $? > $HOME/install-exit-status
cd $HOME

mkdir opm-upscaling/build
cd opm-upscaling/build
$CMAKE $CMAKE_EXTRAS ..
nice make -j $NUM_CPU_CORES
cd $HOME

cd opm-upscaling/build
make upscale_relperm_benchmark
cd $HOME

cd opm-simulators
cd $HOME
echo $FOOTNOTE_INFO > ~/install-footnote

# SETUP OMEGA IF PRESENT
cd $HOME
tar -xvf omega-opm.tar.gz

######################################################
# Run benchmark
######################################################

echo "#!/bin/sh

OMP_NUM_THREADS=\$2

if [ ! \"X\$HOSTFILE\" = \"X\" ] && [ -f \$HOSTFILE ]
then
	HOSTFILE=\"--hostfile \$HOSTFILE\"
elif [ -f /etc/hostfile ]
then
	HOSTFILE=\"--hostfile /etc/hostfile\"
else
	HOSTFILE=\"\"
fi

MPIRUN_AS_ROOT_ARG=\"--allow-run-as-root\"
if [ `whoami` != \"root\" ]
then
  MPIRUN_AS_ROOT_ARG=\"\"
fi

if [ \$1 = \"upscale_relperm_benchmark\" ]
then
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$OMP_NUM_THREADS --map-by socket --report-bindings \$HOSTFILE ./opm-upscaling/build/bin/upscale_relperm_benchmark > \$LOG_FILE 2>&1
elif [ \$1 = \"flow_mpi_norne\" ]
then
	cd opm-data/norne
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$OMP_NUM_THREADS --map-by socket --report-bindings \$HOSTFILE ../../opm-simulators/build/bin/flow_mpi NORNE_ATW2013.DATA > \$LOG_FILE 2>&1
elif [ \$1 = \"flow_mpi_omega\" ]
then
	cd omega-opm
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$OMP_NUM_THREADS --map-by socket --report-bindings \$HOSTFILE ../opm-simulators/build/bin/flow_mpi OMEGA-0.DATA > \$LOG_FILE 2>&1
fi

# echo \$? > ~/test-exit-status" > opm-git
chmod +x opm-git
