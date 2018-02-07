#!/bin/sh

rm -rf $HOME/mafft_
mkdir $HOME/mafft_
tar -xvf mafft-6.864-without-extensions-src.tgz
cd mafft-6.864-without-extensions/core/

make clean

sed -i -e "s|PREFIX = /usr/local|PREFIX = $HOME/mafft_|g" Makefile

make -j $NUM_CPU_JOBS ENABLE_MULTITHREAD=-Denablemultithread
echo $? > ~/install-exit-status
make install
cd ~/
cp -f mafft-6.864-without-extensions/scripts/mafft mafft_/
rm -rf mafft-6.864-without-extensions/

bunzip2 pyruvate_decarboxylase.fasta.bz2 -c > mafft_/pyruvate_decarboxylase.fasta

cat>mafft<<EOT
#!/bin/sh
cd mafft_/
./mafft --thread \$NUM_CPU_CORES --localpair --maxiterate 10000 pyruvate_decarboxylase.fasta > \$LOG_FILE
echo \$? > ~/test-exit-status
EOT
chmod +x mafft
