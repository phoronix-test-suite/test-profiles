#!/bin/sh

# Based on script sent over by Lars Vingli Odsaeter

######################################################
# Obtain source code
######################################################

# Checkout DUNE core modules from SVN
# echo p | svn co --force https://svn.dune-project.org/svn/dune-common/branches/release-2.2 dune-common
# echo p | svn co --force https://svn.dune-project.org/svn/dune-geometry/branches/release-2.2 dune-geometry
# echo p | svn co --force https://svn.dune-project.org/svn/dune-grid/branches/release-2.2 dune-grid
# echo p | svn co --force https://svn.dune-project.org/svn/dune-istl/branches/release-2.2 dune-istl

# Clone OPM modules
# git clone https://github.com/OPM/opm-core.git
# git clone https://github.com/OPM/opm-porsol.git
# git clone https://github.com/OPM/opm-upscaling.git
# git clone https://github.com/OPM/dune-cornerpoint.git
# git clone https://github.com/OPM/opm-benchmarks.git

######################################################
# Build from source
######################################################

tar -xjvf opm-20121026-src.tar.bz2
cd ~/opm-20121026-src/opm-core/
autoreconf -i
cd ~/opm-20121026-src/

nice dune-common/bin/dunecontrol --opts=opm-benchmarks/config.opts all
# echo $? > ~/install-exit-status
# You may want to edit the config.opts file
cd ~

######################################################
# Run benchmark
######################################################

echo "#!/bin/sh
cd ~/opm-20121026-src/
nice mpirun -np \$NUM_CPU_CORES \$@ > \$LOG_FILE 2>&1
# echo \$? > ~/test-exit-status" > open-porous-media
chmod +x open-porous-media
