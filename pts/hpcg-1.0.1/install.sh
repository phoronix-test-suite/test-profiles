#!/bin/sh

tar -zxvf hpcg-1.1.tar.gz
cd hpcg-1.1

# Find MPI To Use
if [ ! "X$MPI_PATH" = "X" ] && [ -d $MPI_PATH ] && [ -d $MPI_INCLUDE ] && [ -x $MPI_CC ] && [ -e $MPI_LIBS ]
then
	# PRE-SET MPI
	echo "Using pre-set environment variables."
elif [ -d /usr/lib/openmpi/include ]
then
	# OpenMPI On Ubuntu
	MPI_PATH=/usr/lib/openmpi
	MPI_INCLUDE=/usr/lib/openmpi/include
	MPI_LIBS=/usr/lib/openmpi/lib/libmpi.so
	MPI_CC=/usr/bin/mpicxx.openmpi
	MPI_VERSION=`$MPI_CC -showme:version 2>&1 | grep MPI | cut -d "(" -f1  | cut -d ":" -f2`
elif [ -d /usr/lib64/openmpi ]
then
	# OpenMPI On RHEL
	MPI_PATH=/usr/lib64/openmpi
	MPI_INCLUDE=/usr/include/openmpi-x86_64/
	MPI_LIBS=/usr/lib64/openmpi/lib/libmpi.so
	MPI_CC=/usr/lib64/openmpi/bin/mpicxx
	MPI_VERSION=`$MPI_CC -showme:version 2>&1 | grep MPI | cut -d "(" -f1  | cut -d ":" -f2`
elif [ -d /usr/lib/mpich/include ]
then
	# MPICH
	MPI_PATH=/usr/lib/mpich
	MPI_INCLUDE=/usr/lib/mpich/include
	MPI_LIBS=/usr/lib/libmpich.so.1.0
	MPI_CC=/usr/lib/mpich/bin/mpicxx.mpich
	MPI_VERSION=`$MPI_CC -v 2>&1 | grep "MPICH version"`
elif [ -d /usr/include/mpich2 ]
then
	# MPICH2
	MPI_PATH=/usr/include/mpich2
	MPI_INCLUDE=/usr/include/mpich2
	MPI_LIBS=/usr/lib/mpich2/lib/libmpich.so
	MPI_CC=/usr/bin/mpicxx.mpich2
	MPI_VERSION=`$MPI_CC -v 2>&1 | grep "MPICH2 version"`
elif [ -d /usr/include/mpich2-x86_64 ]
then
	# MPICH2
	MPI_PATH=/usr/include/mpich2-x86_64
	MPI_INCLUDE=/usr/include/mpich2-x86_64
	MPI_LIBS=/usr/lib64/mpich2/lib/libmpich.so
	MPI_CC=/usr/bin/mpicxx
	MPI_VERSION=`$MPI_CC -v 2>&1 | grep "MPICH2 version"`
fi

if [ ! "X$MPI_VERSION" = "X" ]
then
	VERSION_INFO=$MPI_VERSION
	if [ ! "X$LA_VERSION" = "X" ]
	then
		VERSION_INFO="$LA_VERSION + $VERSION_INFO"
	fi

	echo $VERSION_INFO > ~/install-footnote
fi

if [ "X$CFLAGS_OVERRIDE" = "X" ]
then
          CFLAGS="$CFLAGS -O3 -march=native -ffast-math -ftree-vectorize"
else
          CFLAGS="$CFLAGS_OVERRIDE"
fi

if [ "X$MPI_LD" = "X" ]
then
	MPI_LD=$MPI_CC
fi

# Make.pts generation
echo "SHELL        = /bin/sh
CD           = cd
CP           = cp
LN_S         = ln -s -f
MKDIR        = mkdir -p
RM           = /bin/rm -f
TOUCH        = touch
TOPdir       = .
SRCdir       = \$(TOPdir)/src
INCdir       = \$(TOPdir)/src
BINdir       = \$(TOPdir)/bin
MPdir        = $MPI_PATH
MPinc        = -I$MPI_INCLUDE
MPlib        = $MPI_LIBS
HPCG_INCLUDES = -I\$(INCdir) -I\$(INCdir)/\$(arch) \$(MPinc)
HPCG_LIBS     = 
HPCG_OPTS     = 
CXX          = $MPI_CC
CXXFLAGS     = \$(HPCG_DEFS) -fopenmp $CFLAGS
LINKER       = $MPI_LD
LINKFLAGS    = \$(CXXFLAGS)
ARCHIVER     = ar
ARFLAGS      = r
RANLIB       = echo
" > setup/Make.pts

./configure arch=pts
make
echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd hpcg-1.1/bin/
rm -f *.yaml

if [ \"X\$MPI_NUM_THREADS\" = \"X\" ]
then
	MPI_NUM_THREADS=\$NUM_CPU_CORES
fi

if [ ! \"X\$HOSTFILE\" = \"X\" ] && [ -f \$HOSTFILE ]
then
	\$HOSTFILE=\"--hostfile \$HOSTFILE\"
elif [ -f /etc/hostfile ]
then
	\$HOSTFILE=\"--hostfile /etc/hostfile\"
fi

PATH=\$PATH:$MPI_PATH/bin
LD_PRELOAD=$MPI_LIBS mpirun -np \$MPI_NUM_THREADS \$HOSTFILE xhpcg
echo \$? > ~/test-exit-status

cat *.yaml > \$LOG_FILE
rm -f *.yaml" > hpcg
chmod +x hpcg
