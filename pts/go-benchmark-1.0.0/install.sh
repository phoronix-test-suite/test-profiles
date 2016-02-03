#!/bin/bash

export GOPATH=$HOME/gobench
TESTDIR=$GOPATH/src/golang.org/x
mkdir -p $TESTDIR
tar -xf golang-benchmarks-dbc03b1.tar.gz -C $TESTDIR
mv $TESTDIR/golang-benchmarks-dbc03b1 $TESTDIR/benchmarks
go install golang.org/x/benchmarks/bench

echo "#!/bin/bash
pushd $HOME/gobench
./bin/bench  \$@ &>> \$LOG_FILE
echo \$? > ~/test-exit-status" > go-benchmark
chmod +x go-benchmark
