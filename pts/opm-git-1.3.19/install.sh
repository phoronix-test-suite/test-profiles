#!/bin/bash

# Clean up in case of any Git issues
WDIR=$PWD
cd $WDIR

if test -z $NUM_CPU_CORES
then
  if test -n `which nproc`
  then
    NUM_CPU_CORES=`nproc`
  else
    NUM_CPU_CORES=1
  fi
fi

# Remove all repositories from previous download
for repo in opm-data opm-common opm-material opm-grid opm-simulators libecl ewoms dune-common dune-geometry dune-grid dune-istl
do
  rm -rf $repo
done

# Remove Boost and Install folder
for folder in boost_1_58_0 Install download
do
    rm -rf $folder
done


# Download source from github
FOOTNOTE_INFO="Build Time `date`; "

# Build all modules

# Install prerequisites and remove conflicting packages
sudo apt-get install build-essential cmake git wget libblas-dev liblapack-dev libsuitesparse-dev libtrilinos-zoltan-dev mpi-default-dev mpi-default-bin
sudo apt-get remove libdune-common-dev libdune-grid-dev libdune-geometry-dev libdune-istl-dev libsuperlu-dev libsuperlu5

# Make Install folder
mkdir $WDIR/Install

# Download and build a known good version of Boost
wget https://sourceforge.net/projects/boost/files/boost/1.58.0/boost_1_58_0.tar.gz/download
tar -xzf download
pushd boost_1_58_0
./bootstrap.sh --prefix=$WDIR/Install
./b2 -j $NUM_CPU_CORES ; ./b2 install
popd

#Download and build necessary Dune modules version 2.4.1
for repo in dune-common dune-geometry dune-grid dune-istl
do
            git clone --depth 1 -b v2.4.1 https://gitlab.dune-project.org/core/$repo.git
            mkdir $repo/build
            pushd $repo/build
            cmake -DCMAKE_INSTALL_PREFIX=$WDIR/Install \
                  -Ddune-common_DIR==$WDIR/dune-common/build \
                  -Ddune-geometry_DIR==$WDIR/dune-geometry/build \
                  -Ddune-grid_DIR==$WDIR/dune-grid/build \
                  -DDUNE_GRID_EXPERIMENTAL_GRID_EXTENSIONS=ON \
                  -DCMAKE_PREFIX_PATH=$WDIR/Install ..
            make -j $NUM_CPU_CORES ; make install
            popd
done

#Download and build libecl from git
git clone --depth 1 https://github.com/Statoil/libecl.git
mkdir libecl/build ; 
pushd libecl/build
cmake .. -DCMAKE_BUILD_TYPE=Release
make -j $NUM_CPU_CORES 
popd

#Download and build opm simulators with MPI support from git
for repo in opm-common opm-grid opm-material ewoms opm-simulators
do
    git clone --depth 1 https://github.com/OPM/$repo.git
    mkdir $repo/build
    pushd $repo/build
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_PREFIX_PATH=$WDIR/Install \
          -DUSE_MPI=ON -Decl_DIR=$WDIR/libecl/build -DBUILD_TESTING=OFF ..
    make -j $NUM_CPU_CORES 
    ecode=$?
    echo $? > ~/install-exit-status
    test $? -eq 0 || exit 1
    popd
done

echo $FOOTNOTE_INFO > ~/install-footnote

# SETUP OMEGA IF PRESENT
if test -f $HOME/omega-opm.tar.gz
then
  git clone --depth 1 https://github.com/OPM/opm-data.git
  pushd opm-data
  tar -xvf ~/omega-opm.tar.gz
  popd
fi

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
	cd opm-data/omega-opm
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$OMP_NUM_THREADS --map-by socket --report-bindings \$HOSTFILE ../../opm-simulators/build/bin/flow OMEGA-0.DATA > \$LOG_FILE 2>&1
elif [ \$1 = \"flow_mpi_extra\" ]
then
	cd opm-data/omega-opm
	nice mpirun \$MPIRUN_AS_ROOT_ARG -np \$OMP_NUM_THREADS --map-by socket --report-bindings \$HOSTFILE ../../opm-simulators/build/bin/flow OMEGA-0.DATA > \$LOG_FILE 2>&1
fi

# echo \$? > ~/test-exit-status" > opm-git
chmod +x opm-git
