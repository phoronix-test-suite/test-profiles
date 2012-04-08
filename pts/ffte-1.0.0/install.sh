#!/bin/sh

tar -xzvf ffte-5.0.tgz
cd ~/ffte-5.0/tests/
make
cd ~/ffte-5.0/mpi/tests/
make

cd ~/

cat>ffte<<EOT
#!/bin/sh
cd ~/ffte-5.0/
\$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
EOT
chmod +x ffte

