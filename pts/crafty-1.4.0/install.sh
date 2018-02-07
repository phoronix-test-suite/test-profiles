#!/bin/sh

unzip -o crafty-25.2.zip


if [ "X$CFLAGS_OVERRIDE" = "X" ]
then
          CFLAGS="$CFLAGS -O3 -march=native"
else
          CFLAGS="$CFLAGS_OVERRIDE"
fi

export CFLAGS="-Wall -pipe -fomit-frame-pointer $CFLAGS"
export CXFLAGS="-Wall -pipe -O3 -fomit-frame-pointer"
export LDFLAGS="$LDFLAGS -lstdc++"
make unix-gcc

echo $? > ~/install-exit-status

cd ~

echo "#!/bin/sh
./crafty \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > crafty-benchmark
chmod +x crafty-benchmark
