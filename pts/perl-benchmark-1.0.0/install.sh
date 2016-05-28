#!/bin/bash

unzip perlbench-20160525.zip
echo $? > ~/install-exit-status
echo "#!/bin/sh
cd perlbench-master
./perlbench-runtests \$@ >\$LOG_FILE
cat ../perl-benchmark-*.log > result_file
grep "Test-Result" result_file | cut -f2 -d":" | xargs -i cat {} >> \$LOG_FILE
echo \$? > ~/test-exit-status" > perl-benchmark
chmod +x perl-benchmark
