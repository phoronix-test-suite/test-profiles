#!/bin/sh

tar -xzvf fftw-3.3.4.tar.gz
rm -rf fftw-mr
rm -rf fftw-stock

mv fftw-3.3.4 fftw-stock
cp -a fftw-stock fftw-mr

cd fftw-mr
./configure --enable-float --enable-sse
make

cd ~/fftw-stock
./configure
make
echo $? > ~/install-exit-status

cd ~/
echo "
#!/bin/sh

./\$@ | \
    awk '(\$8 == \"s,\") { printf \"%f FFT/sec\\n\", 1 / \$7 } \
         (\$8 == \"ms,\") { printf \"%f FFT/sec\\n\", 1 / (\$7 / 1000) } \
         (\$8 == \"us,\") { printf \"%f FFT/sec\\n\", 1 / (\$7 / 1000000 ) } \
         (\$8 == \"ns,\") { printf \"%f FFT/sec\\n\", 1 / (\$7 / 1000000000 ) } \
         {printf \"%f mflops\\n\", \$10 }' > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
" > fftw

chmod +x fftw

