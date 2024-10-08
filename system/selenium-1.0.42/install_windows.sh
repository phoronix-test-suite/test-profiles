#!/bin/sh
unzip -o selenium-scripts-10.zip
# Drivers
unzip -o geckodriver-v0.32.0-win32.zip
unzip -o chromedriver-win64-128.zip
mv chromedriver-win64/chromedriver.exe .
pip3 install --user selenium==3.141.0
HOME=$DEBUG_REAL_HOME pip3 install --user selenium==3.141.0
# Script
echo "#!/bin/sh
HOME=\$DEBUG_REAL_HOME cmd /c \"\$DEBUG_REAL_HOME\AppData\Local\Programs\Python\Python37\Scripts\pip3.exe\" install --user selenium==3.141.0
rm -f run-benchmark.py
cp -f selenium-run-\$1.py run-benchmark.py
sed -i \"s/Firefox/\$2/g\" run-benchmark.py

echo \"from selenium import webdriver
driver = webdriver.\$2()
if \\\"browserName\\\" in driver.capabilities:
	browserName = driver.capabilities['browserName']

if \\\"browserVersion\\\" in driver.capabilities:
	browserVersion = driver.capabilities['browserVersion']
else:
	browserVersion = driver.capabilities['version']

print('{0} {1}'.format(browserName, browserVersion))
driver.quit()\" > browser-version.py

cmd /c \"\$DEBUG_REAL_HOME\AppData\Local\Programs\Python\Python37\python.exe\"  ./run-benchmark.py > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status

cmd /c \"\$DEBUG_REAL_HOME\AppData\Local\Programs\Python\Python37\python.exe\" ./browser-version.py > ~/pts-footnote
" > selenium
chmod +x selenium
