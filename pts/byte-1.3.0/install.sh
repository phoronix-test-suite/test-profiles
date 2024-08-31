#!/bin/sh
unzip -o byte-unixbench-a07fcc03264915c624f0e4818993c5b4df3fa703.zip
cd byte-unixbench-a07fcc03264915c624f0e4818993c5b4df3fa703/UnixBench
make clean
make
echo $? > ~/install-exit-status
cd ~
echo "#!/bin/sh
rm -f result
cd byte-unixbench-a07fcc03264915c624f0e4818993c5b4df3fa703/UnixBench
./Run \$1 > \$LOG_FILE" > byte
chmod +x byte
