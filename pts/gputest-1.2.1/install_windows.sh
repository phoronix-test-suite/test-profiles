#!/bin/sh

unzip -o GpuTest_Windows_x64_0.6.0.zip

echo "#!/bin/sh
rm -f _geeks3d_gputest_log.txt
GpuTest.exe \$@ 
cat _geeks3d_gputest_log.txt > \$LOG_FILE" > gputest
chmod +x gputest
