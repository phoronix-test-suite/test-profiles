#!/bin/sh
tar -xf c-ray-2.0.tar.gz
cd c-ray-2.0
make
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
cd c-ray-2.0
./c-ray-fast \$@ -i sphfract.scn -o output.ppm > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > c-ray
chmod +x c-ray
