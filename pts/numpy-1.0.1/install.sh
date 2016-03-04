#!/bin/sh

tar -xvf numpy-benchmarks-20160218.tar.gz
echo $? > ~/install-exit-status
echo "#!/bin/sh
cd numpy-benchmarks-master/
python run.py -t python > numpy_log
echo 'Test name :   Avg time ( nanoseconds )'
cat numpy_log | awk 'BEGIN{total_avg_time=0} {print \$1\":\"\$4;total_avg_time+=\$4;} END{printf(\"\n\n-------------------\nTotal avg time (nanoseconds): %.02f\n\", total_avg_time);}' \$@ > \$LOG_FILE
echo \$? > ~/test-exit-status " > numpy
chmod +x numpy
