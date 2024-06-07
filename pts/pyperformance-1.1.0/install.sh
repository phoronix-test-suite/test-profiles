#!/bin/sh
pip3 install --user pyperf==2.6.3 psutil==5.9.5 packaging==23.1
pip3 install --user pyperformance==1.11
echo $? > ~/install-exit-status
echo "#!/bin/sh
~/.local/bin/pyperformance run \$@ > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > pyperformance
chmod +x pyperformance
