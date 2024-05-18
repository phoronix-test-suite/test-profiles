#!/bin/sh
rm -rf glibc-2.39
tar -xf glibc-2.39.tar.xz
cd glibc-2.39
mkdir build
cd build
../configure  --disable-sanity-checks CFLAGS="-O3 -U_FORTIFY_SOURCE -Wno-error=attributes -Wno-error=cpp $CFLAGS"
make -j $NUM_CPU_CORES
make bench-build
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd glibc-2.39/build/benchtests/
CONV_PATH=\$HOME/glibc-2.39/build/iconvdata LOCPATH=\$HOME/glibc-2.39/build/localedata LC_ALL=C   \$HOME/glibc-2.39/build/elf/ld.so --library-path \$HOME/glibc-2.39/build:\$HOME/glibc-2.39/build/math:\$HOME/glibc-2.39/build/elf:\$HOME/glibc-2.39/build/dlfcn:\$HOME/glibc-2.39/build/nss:\$HOME/glibc-2.39/build/nis:\$HOME/glibc-2.39/build/rt:\$HOME/glibc-2.39/build/resolv:\$HOME/glibc-2.39/build/mathvec:\$HOME/glibc-2.39/build/support:\$HOME/glibc-2.39/build/crypt:\$HOME/glibc-2.39/build/nptl ./\$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > glibc-bench
chmod +x glibc-bench
