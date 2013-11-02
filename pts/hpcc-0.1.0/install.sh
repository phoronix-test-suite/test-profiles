#!/bin/sh

tar -zxvf hpcc-1.4.3.tar.gz
cd hpcc-1.4.3

cat << 'EOF' > hpl/Make.pts
SHELL        = /bin/sh
CD           = cd
CP           = cp
LN_S         = ln -s
MKDIR        = mkdir
RM           = /bin/rm -f
TOUCH        = touch
ARCH         = $(arch)
TOPdir       = ../../..
INCdir       = $(TOPdir)/include
BINdir       = $(TOPdir)/bin/$(ARCH)
LIBdir       = $(TOPdir)/lib/$(ARCH)
HPLlib       = $(LIBdir)/libhpl.a 

# MPI

MPdir        = /usr/lib/openmpi
MPinc        = -I$(MPdir)/include
MPlib        = $(MPdir)/lib/libmpi.so

# BLAS or VSIPL

LAdir        = /usr/lib
LAinc        = 
LAlib        = -lblas -latlas -llapack -lcblas

# F77 / C interface 

F2CDEFS      =

# HPL includes / libraries / specifics

HPL_INCLUDES = -I$(INCdir) -I$(INCdir)/$(ARCH) $(LAinc) $(MPinc)
HPL_LIBS     = $(HPLlib) $(LAlib) $(MPlib) -lm
HPL_OPTS     = -DHPL_CALL_CBLAS
HPL_DEFS     = $(F2CDEFS) $(HPL_OPTS) $(HPL_INCLUDES)
CC           = mpicc
CCNOOPT      = $(HPL_DEFS)
CCFLAGS      = $(HPL_DEFS) -fomit-frame-pointer -O3 -march=native -funroll-loops
LINKER       = mpicc
LINKFLAGS    = $(CCFLAGS)
ARCHIVER     = ar
ARFLAGS      = r
RANLIB       = echo
EOF

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
