#!/bin/sh
tar -xf WarpX-24.10.tar.gz
cd WarpX-24.10
cmake -S . -DAMReX_OMP=OFF -DCMAKE_BUILD_TYPE=Release -B build
cmake --build build -j $NUM_CPU_CORES
echo $? > ~/install-exit-status
cd ~
cat>warpx<<EOT
#!/bin/sh
cd WarpX-24.10/Examples/Physics_applications/
cd "\$1"
echo Data | mpirun --allow-run-as-root -np \$NUM_CPU_PHYSICAL_CORES ~/WarpX-24.10/build/bin/warpx.3d "\$2" max_step=\$3 > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status
rm -rf diags
EOT
chmod +x warpx
