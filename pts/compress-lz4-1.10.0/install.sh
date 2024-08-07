#!/bin/sh
tar -xf lz4-1.10.0.tar.gz
cd lz4-1.10.0
make
echo $? > ~/install-exit-status
cd ~
cat > compress-lz4 <<EOT
#!/bin/sh
./lz4-1.10.0/lz4 \$@ silesia.tar > \$LOG_FILE 2>&1
echo $? > ~/test-exit-status
EOT
chmod +x compress-lz4
