#!/bin/sh

tar -zxvf bzip2-1.0.6.tar.gz
tar -zxvf pbzip2-1.1.6.tar.gz
cd bzip2-1.0.6/
make
cp -f libbz2.a ../pbzip2-1.1.6
cp -f bzlib.h ../pbzip2-1.1.6
cd ..
cd pbzip2-1.1.6/
make pbzip2-static
echo $? > ~/install-exit-status

cd ..

cat > compress-pbzip2 <<EOT
#!/bin/sh
cd pbzip2-1.1.6/
./pbzip2 -c -p\$NUM_CPU_CORES -r -5 ../compressfile > /dev/null 2>&1
EOT
chmod +x compress-pbzip2
