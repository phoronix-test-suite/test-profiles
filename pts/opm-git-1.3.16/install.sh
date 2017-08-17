#!/bin/sh

# Clean up in case of any Git issues
rm -rf opm-data
rm -rf opm-parser
rm -rf opm-output
rm -rf opm-common
rm -rf opm-core
rm -rf opm-material
rm -rf opm-upscaling
rm -rf opm-grid
rm -rf opm-simulators
rm -rf opm-polymer
rm -rf libecl
rm -rf ewoms
rm -rf dune-common
rm -rf dune-geometry
rm -rf dune-grid
rm -rf dune-istl

# Download source from github
FOOTNOTE_INFO="Build Time `date`; "

cd ~

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

# Build all modules
#!/bin/bash

# Install prerequisites
# sudo apt-get install build-essential cmake git wget libblas-dev liblapack-dev libsuitesparse-dev libtrilinos-zoltan-dev mpi-default-dev
# sudo apt-get install build-essential cmake git wget libblas-dev liblapack-dev libsuitesparse-dev
# sudo apt-get remove libdune-common-dev libdune-grid-dev libdune-geometry-dev libdune-istl-dev 
# apt-get install libtrilinos-zoltan-dev mpi-default-dev
# Download and build a know good version of Boost
wget https://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz/download
tar -xzf download
cd boost_1_58_0
./bootstrap.sh --prefix=../Install
./b2 -j $NUM_CPU_CORES ; ./b2 install ; cd ..

#Download and build necessary Dune modules version 2.4.1
for repo in dune-common dune-geometry dune-grid dune-istl
do
            git clone https://gitlab.dune-project.org/core/$repo.git
            mkdir $repo/build ; cd $repo/build
            git checkout v2.4.1
            cmake -DCMAKE_INSTALL_PREFIX=../../Install \
                  -DDUNE_GRID_EXPERIMENTAL_GRID_EXTENSIONS=TRUE  \
                  -DCMAKE_PREFIX_PATH=../../Install ..
            make -j $NUM_CPU_CORES ; make install ; cd ../..
done

#Download and build libecl from git
git clone https://github.com/Statoil/libecl.git
mkdir libecl/build ; cd libecl/build
cmake ..
make -j $NUM_CPU_CORES ; cd ../..

#Download and build opm simulators with MPI support from git
for repo in opm-data opm-common opm-parser opm-grid opm-output opm-material opm-core ewoms opm-simulators 
do
    git clone https://github.com/OPM/$repo.git
    mkdir $repo/build && cd $repo/build
    cmake -DCMAKE_CXX_FLAGS="-O3 -DNDEBUG -mtune=native" \
          -DCMAKE_PREFIX_PATH=../Install \
          -DUSE_MPI=ON ..
    make -j $NUM_CPU_CORES ; cd ../..
    echo $? > ~/install-exit-status
done


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
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$OMP_NUM_THREADS --map-by socket --report-bindings \$HOSTFILE ../../opm-simulators/build/bin/flow NORNE_ATW2013.DATA > \$LOG_FILE 2>&1
elif [ \$1 = \"flow_ebos_extra\" ]
then
	cd omega-opm
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$OMP_NUM_THREADS --map-by socket --report-bindings \$HOSTFILE ../opm-simulators/build/bin/flow OMEGA-0.DATA > \$LOG_FILE 2>&1
elif [ \$1 = \"flow_mpi_extra\" ]
then
	cd omega-opm
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$OMP_NUM_THREADS --map-by socket --report-bindings \$HOSTFILE ../opm-simulators/build/bin/flow OMEGA-0.DATA > \$LOG_FILE 2>&1
fi

# echo \$? > ~/test-exit-status" > opm-git
chmod +x opm-git
