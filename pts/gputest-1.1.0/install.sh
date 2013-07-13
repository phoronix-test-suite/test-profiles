#!/bin/sh

unzip -o GpuTest_Linux_x64_0.5.0.zip
mv GpuTest GpuTest_Bin
chmod +x GpuTest_Bin

echo "#!/bin/sh
rm -f _geeks3d_gputest_log.txt
./GpuTest_Bin \$@ 
cat _geeks3d_gputest_log.txt > \$LOG_FILE" > gputest
chmod +x gputest
