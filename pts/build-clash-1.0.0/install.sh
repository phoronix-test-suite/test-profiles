#!/usr/bin/env bash

## This requires the Nix package manager to function,
## both for the dependencies, and for the benchmark itself.
##
## Nix installation instructions:
##
##  https://nixos.org/download.html
##
## Once complete, this will set up the system-global /nix/store,
## which will cache the full set of benchmark dependencies,
## which should take under one gigabyte.

## Set this, once pinning a version of benchmark-compilation
## is desired.
revision=

git clone https://github.com/deepfire/benchmark-compilation

cat > build-clash <<EOF
#!/usr/bin/env bash

cd benchmark-compilation
git reset --hard ${revision}

options=(
  --iterations 1
  --cores      \$NUM_CPU_CORES
)

./bench/bench.sh "\${options[@]}" measure 2>&1
echo \$? > ~/test-exit-status
EOF

chmod +x build-clash

## Fill the Nix store.
cd benchmark-compilation
git reset --hard ${revision}

./bench/bench.sh prepare 2>&1
