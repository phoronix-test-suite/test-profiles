#!/bin/sh

mkdir $HOME/gpgerror
tar -jxf libgpg-error-1.7.tar.bz2
cd libgpg-error-1.7/
./configure --prefix=$HOME/gpgerror
make -j $NUM_CPU_JOBS
make install
cd ~
rm -rf libgpg-error-1.7/

tar -jxf libgcrypt-1.4.4.tar.bz2
cd libgcrypt-1.4.4/
patch -p0 <<'EOT'
--- tests/Makefile.in~ 2009-01-22 12:16:51.000000000 -0600
 tests/Makefile.in 2014-01-22 19:30:52.289933436 -0600
@@ -248,7 248,7 @@
 LIBGCRYPT_PUBKEY_CIPHERS = @LIBGCRYPT_PUBKEY_CIPHERS@
 LIBGCRYPT_THREAD_MODULES = @LIBGCRYPT_THREAD_MODULES@
 LIBOBJS = @LIBOBJS@
-LIBS = @LIBS@
LIBS = @GPG_ERROR_LIBS@
 LIBTOOL = @LIBTOOL@
 LN_S = @LN_S@
 LTLIBOBJS = @LTLIBOBJS@
EOT

./configure --with-gpg-error-prefix=$HOME/gpgerror
make -j $NUM_CPU_JOBS
echo \$? > ~/install-exit-status
cd ~

echo "#!/bin/sh
./libgcrypt-1.4.4/tests/benchmark \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > gcrypt
chmod +x gcrypt


