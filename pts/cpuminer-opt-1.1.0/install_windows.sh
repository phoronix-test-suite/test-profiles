#!/bin/sh

unzip -o cpuminer-opt-3.8.3.3-windows.zip

echo "#!/bin/sh
cd cpuminer-opt-3.8.3.3-windows
./cpuminer-avx2.exe --quiet --time-limit=30 --benchmark \$@ > \$LOG_FILE" > cpuminer-opt
chmod +x cpuminer-opt
