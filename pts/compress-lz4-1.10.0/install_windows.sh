#!/bin/sh
unzip -o lz4_win64_v1_10_0.zip
chmod +x lz4.exe
cat > compress-lz4 <<EOT
#!/bin/sh
./lz4.exe \$@ silesia.tar > \$LOG_FILE 2>&1
EOT
chmod +x compress-lz4
