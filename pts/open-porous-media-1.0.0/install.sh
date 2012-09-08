#!/bin/sh

# Based on script sent over by Lars Vingli Odsaeter
# This script downloads all necessary source code, build the DUNE and OPM modules and finally run the benchmark

######################################################
# Obtain source code
######################################################

# Checkout DUNE core modules from SVN at correct revision
echo p | svn co --force -r 6815 https://svn.dune-project.org/svn/dune-common/branches/release-2.2 dune-common
echo p | svn co --force -r 113 https://svn.dune-project.org/svn/dune-geometry/branches/release-2.2 dune-geometry
echo p | svn co --force -r 8252 https://svn.dune-project.org/svn/dune-grid/branches/release-2.2 dune-grid
echo p | svn co --force -r 1639 https://svn.dune-project.org/svn/dune-istl/branches/release-2.2 dune-istl

# Clone OPM modules and checkout correct revision
git clone https://github.com/OPM/opm-core.git
git --git-dir="opm-core/.git" --work-tree="opm-core/" checkout 8fefee7295

git clone https://github.com/OPM/opm-porsol.git
git --git-dir="opm-porsol/.git" --work-tree="opm-porsol/" checkout 10b4001891

git clone https://github.com/OPM/opm-upscaling.git
git --git-dir="opm-upscaling/.git" --work-tree="opm-upscaling/" checkout 22b1be3d50

git clone https://github.com/OPM/dune-cornerpoint.git
git --git-dir="dune-cornerpoint/.git" --work-tree="dune-cornerpoint/" checkout ef46036e9a

git clone https://github.com/OPM/opm-benchmarks.git
git --git-dir="opm-benchmarks/.git" --work-tree="opm-benchmarks/" checkout 7012ae1249c8fc932d800ffc65dc631ba7dc4e87

######################################################
# Build from source
######################################################

nice dune-common/bin/dunecontrol --opts=opm-benchmarks/config.opts all
echo $? > ~/install-exit-status
# You may want to edit the config.opts file


######################################################
# Run benchmark
######################################################

echo "#!/bin/sh
nice mpirun -np \$NUM_CPU_CORES \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > open-porous-media
chmod +x open-porous-media
