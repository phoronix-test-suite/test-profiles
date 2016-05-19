#!/bin/bash

export GOPATH=$HOME/gobench
TESTDIR=$GOPATH/src/golang.org/x
mkdir -p $TESTDIR
tar -xf golang-benchmarks-e7f1879.tar.gz -C $TESTDIR
mv $TESTDIR/benchmarks-master $TESTDIR/benchmarks
go install golang.org/x/benchmarks/bench

echo "#!/bin/bash
pushd $HOME/gobench
./bin/bench  \$@ &>> \$LOG_FILE
echo \$? > ~/test-exit-status" > go-benchmark
chmod +x go-benchmark
