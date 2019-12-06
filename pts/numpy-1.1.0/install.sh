#!/bin/sh

tar -xvf numpy-benchmarks-20190903.tar.gz
echo $? > ~/install-exit-status
echo "#!/bin/sh
cd numpy-benchmarks-master/
python2 run.py -t python -p \$1 > numpy_log
echo 'Test name :   Avg time ( nanoseconds )'
cat numpy_log | awk 'BEGIN{geo_mean=1; count=0;} {print \$1\":\"\$4;geo_mean*=\$4;count+=1} END{printf(\"\n\n-------------------\nGeometric mean score: %.02f\n\", 1000000/(geo_mean**(1.0/count)));}' > \$LOG_FILE
echo \$? > ~/test-exit-status " > numpy
chmod +x numpy
