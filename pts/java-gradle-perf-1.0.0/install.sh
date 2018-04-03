#!/bin/sh


# Only get the tag we want
git clone --depth 1 git@github.com:reactor/reactor-core.git
cd reactor-core
git fetch origin v2.5.0.M1:tags/v2.5.0.M1
git checkout v2.5.0.M1

# build once to get all dependencies
./gradlew build
cd ..

echo "#!/bin/sh
cd reactor-core
# Building offline to get consistent timing
./gradlew --offline clean build > \$LOG_FILE
echo \$? > ~/test-exit-status" > java-gradle-perf
chmod +x java-gradle-perf
