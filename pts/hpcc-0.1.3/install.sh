#!/bin/sh

tar -zxvf hpcc-1.4.3.tar.gz
cd hpcc-1.4.3

if [ -d /usr/lib/openmpi/include ]
then
	MPI_PATH=/usr/lib/openmpi
	MPI_INCLUDE=/usr/lib/openmpi/include
	MPI_LIBS=/usr/lib/openmpi/lib/libmpi.so
	MPI_CC=/usr/bin/mpicc.openmpi
elif [ -d /usr/lib/mpich/include ]
then
	MPI_PATH=/usr/lib/mpich
	MPI_INCLUDE=/usr/lib/mpich/include
	MPI_LIBS=/usr/lib/libmpich.so.1.0
	MPI_CC=/usr/lib/mpich/bin/mpicc
elif [ -d /usr/include/mpich2 ]
then
	MPI_PATH=/usr/include/mpich2
	MPI_INCLUDE=/usr/include/mpich2
	MPI_LIBS=/usr/lib/mpich2/lib/libmpich.so
	MPI_CC=/usr/bin/mpicc.mpich2
fi

# Make.pts generation
echo "
SHELL        = /bin/sh
CD           = cd
CP           = cp
LN_S         = ln -s
MKDIR        = mkdir
RM           = /bin/rm -f
TOUCH        = touch
ARCH         = \$(arch)
TOPdir       = ../../..
INCdir       = \$(TOPdir)/include
BINdir       = \$(TOPdir)/bin/\$(ARCH)
LIBdir       = \$(TOPdir)/lib/\$(ARCH)
HPLlib       = \$(LIBdir)/libhpl.a 

# MPI

MPdir        = $MPI_PATH
MPinc        = -I$MPI_INCLUDE
MPlib        = $MPI_LIBS

# BLAS or VSIPL

LAdir        = /usr/lib
LAinc        = 
LAlib        = -lblas -latlas -llapack -lcblas

# F77 / C interface 

F2CDEFS      =

# HPL includes / libraries / specifics

HPL_INCLUDES = -I\$(INCdir) -I\$(INCdir)/\$(ARCH) \$(LAinc) \$(MPinc)
HPL_LIBS     = \$(HPLlib) \$(LAlib) \$(MPlib) -lm
HPL_OPTS     = -DHPL_CALL_CBLAS
HPL_DEFS     = \$(F2CDEFS) \$(HPL_OPTS) \$(HPL_INCLUDES)
CC           = $MPI_CC
CCNOOPT      = \$(HPL_DEFS)
CCFLAGS      = \$(HPL_DEFS) -fomit-frame-pointer -O3 -march=native -funroll-loops
LINKER       = $MPI_CC
LINKFLAGS    = \$(CCFLAGS)
ARCHIVER     = ar
ARFLAGS      = r
RANLIB       = echo
" > hpl/Make.pts

# HPL.dat generation
N=$(echo "scale=0;sqrt(${NUM_CPU_CORES}*${SYS_MEMORY}*128)" |bc -l)
PQ=0
P=$(echo "scale=0;sqrt($NUM_CPU_CORES)" |bc -l)
Q=$P
PQ=$(($P*$Q))

while [ $PQ -ne $NUM_CPU_CORES ]; do
    Q=$(($NUM_CPU_CORES/$P))
    PQ=$(($P*$Q))
    if [ $PQ -ne $NUM_CPU_CORES ] && [ $P -gt 1 ]; then P=$(($P-1)); fi
done

echo "HPLinpack benchmark input file
Innovative Computing Laboratory, University of Tennessee
HPL.out      output file name (if any)
6            device out (6=stdout,7=stderr,file)
1            # of problems sizes (N)
$N
1            # of NBs
100          NBs
0            PMAP process mapping (0=Row-,1=Column-major)
1            # of process grids (P x Q)
$P           Ps
$Q           Qs
16.0         threshold
1            # of panel fact
2            PFACTs (0=left, 1=Crout, 2=Right)
1            # of recursive stopping criterium
4            NBMINs (>= 1)
1            # of panels in recursion
2            NDIVs
1            # of recursive panel fact.
2            RFACTs (0=left, 1=Crout, 2=Right)
1            # of broadcast
1            BCASTs (0=1rg,1=1rM,2=2rg,3=2rM,4=Lng,5=LnM)
1            # of lookahead depth
0            DEPTHs (>=0)
1            SWAP (0=bin-exch,1=long,2=mix)
64           swapping threshold
0            L1 in (0=transposed,1=no-transposed) form
0            U  in (0=transposed,1=no-transposed) form
1            Equilibration (0=no,1=yes)
8            memory alignment in double (> 0)
" > HPL.dat

cd hpl/
make arch=pts
cd ..
make arch=pts

echo $? > ~/install-exit-status

cd ~
echo "#!/bin/sh
cd hpcc-1.4.3
export OMP_NUM_THREADS=\$NUM_CPU_CORES
mpirun -np \$NUM_CPU_CORES hpcc
echo \$? > ~/test-exit-status
cat hpccoutf.txt > \$LOG_FILE" > hpcc
chmod +x hpcc
