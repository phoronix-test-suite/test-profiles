#!/bin/sh
mkdir $HOME/httpd_

tar -zxf apache-ab-test-files-1.tar.gz
tar -xf httpd-2.4.62.tar.bz2
tar -xf apr-util-1.6.3.tar.bz2
tar -xf apr-1.7.4.tar.bz2
mv apr-1.7.4 httpd-2.4.62/srclib/apr
mv apr-util-1.6.3 httpd-2.4.62/srclib/apr-util

cd httpd-2.4.62/
./configure --prefix=$HOME/httpd_ --with-included-apr
make -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
make install
cd ~
rm -rf httpd-2.4.62/
rm -rf httpd_/manual/

patch -p0 < CHANGE-APACHE-PORT.patch
mv -f test.html httpd_/htdocs/
mv -f pts.png httpd_/htdocs/

cd ~
tar -xf siege-4.1.5.tar.gz
if [ $OS_TYPE = "BSD" ]
then
        patch -p0 < INCLUDE-SIGNAL-HEADER.patch
fi
cd siege-4.1.5
./configure
make -j $NUM_CPU_CORES
cd utils
bash siege.config
cd ~

echo "#!/bin/sh
cd ~/siege-4.1.5/utils
bash siege.config
cd ~/siege-4.1.5/src
./siege \$@ 2>&1 | grep -v HTTP > \$LOG_FILE
echo \$? > ~/test-exit-status" > apache-siege
chmod +x apache-siege
