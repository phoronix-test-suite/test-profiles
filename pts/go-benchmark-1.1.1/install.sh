#!/bin/bash

export GOPATH=$HOME/gobench
TESTDIR=$GOPATH/src/golang.org
mkdir -p $TESTDIR
tar -xf golang-benchmarks-122017.tar.gz -C $TESTDIR
GOBIN=$PWD go install golang.org/go-benchmark-04122017/x/benchmarks/...

echo "#!/bin/bash
./\$@ &>> log
awk -F \" \" '{print \$3}' log |  sed '\$!d' > \$LOG_FILE
echo \$? > ~/test-exit-status" > go-benchmark
chmod +x go-benchmark
