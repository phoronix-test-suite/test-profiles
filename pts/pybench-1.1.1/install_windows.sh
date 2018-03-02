#!/bin/sh

tar -zxvf pybench-2018-02-16.tar.gz

echo "#!/bin/sh
cd pybench-2018-02-16/
python.exe pybench.py \$@ > \$LOG_FILE" > pybench
chmod +x pybench
