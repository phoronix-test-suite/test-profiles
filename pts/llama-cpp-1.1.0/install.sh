#!/bin/bash
tar -xf llama.cpp-b3067.tar.gz
cd llama.cpp-b3067
make -j LLAMA_OPENBLAS=1 
echo $? > ~/install-exit-status
echo "#!/bin/sh
cd llama.cpp-b3067
./main \$@ -p \"Building a website can be done in 10 simple steps:\" -n 512 -e -t \$NUM_CPU_PHYSICAL_CORES > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/llama-cpp
chmod +x ~/llama-cpp
