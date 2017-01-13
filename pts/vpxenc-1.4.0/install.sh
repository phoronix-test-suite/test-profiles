#!/bin/sh

tar -xjf libvpx-1.6.0.tar.bz2

mkdir vpx
cd libvpx-1.6.0
echo "--- a/vp9/common/vp9_entropymv.h
+++ b/vp9/common/vp9_entropymv.h
@@ -27,12 +27,9 @@
 
 void vp9_adapt_mv_probs(struct VP9Common *cm, int usehp);
 
-// Integer pel reference mv threshold for use of high-precision 1/8 mv
-#define COMPANDED_MVREF_THRESH 8
-
 static INLINE int use_mv_hp(const MV *ref) {
-  return (abs(ref->row) >> 3) < COMPANDED_MVREF_THRESH &&
-         (abs(ref->col) >> 3) < COMPANDED_MVREF_THRESH;
+  const int kMvRefThresh = 64;  // threshold for use of high-precision 1/8 mv
+  return abs(ref->row) < kMvRefThresh && abs(ref->col) < kMvRefThresh;
 }
" | patch -p1 

./configure --disable-install-docs --enable-shared --prefix=$HOME/vpx
make -j $NUM_CPU_JOBS
echo $? > ~/install-exit-status
make install
cd ~
rm -rf libvpx-1.6.0

echo "#!/bin/sh
cd vpx/bin
LD_PRELOAD=../lib/libvpx.so.4  ./vpxenc --best --psnr -v --threads=\$NUM_CPU_CORES -o /dev/null ~/soccer_4cif.y4m 2> \$LOG_FILE 
echo \$? > ~/test-exit-status" > vpxenc
chmod +x vpxenc
