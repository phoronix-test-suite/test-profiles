#!/bin/sh

tar -xvf numpy-benchmarks-20190903.tar.gz
echo $? > ~/install-exit-status
echo "#!/bin/sh
cd numpy-benchmarks-master/
python3 run.py -t python -p python3 > numpy_log
echo \$? > ~/test-exit-status 
echo 'Test name :   Avg time ( nanoseconds )'
cat numpy_log > \$LOG_FILE" > numpy
chmod +x numpy
