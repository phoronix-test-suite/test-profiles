#!/bin/sh

# Note: first command is commented because there's a bug in PTS for Windows: the current working dir is not set to the test dir while executing this script,
#       therefore the second command is used instead as workaround;
#       once this bug is fixed please uncomment the first command and remove the second one, together with this note
#supertuxkart-0.9.3-win64.exe /S /D=%cd%\\supertuxkart-0.9.3-win64
start cmd /C "set _test_install_directory=$1 && call cd ^%_test_install_directory^% && call supertuxkart-0.9.3-win64.exe /S /D=^%cd^%\supertuxkart-0.9.3-win64"

echo "@echo off

set _original_config=%APPDATA%\supertuxkart\0.8.2\config.xml
if exist \"%_original_config%\" (
	set _original_config_found=true
) else (
	set _original_config_found=false
)

if %_original_config_found% equ true (
	:: Make sure to start with the default config
	del config.xml.back
	move \"%_original_config%\" config.xml.back
)
cd supertuxkart-0.9.3-win64
supertuxkart.exe %* 2>&1
copy /Y \"%APPDATA%\supertuxkart\0.8.2\stdout.log\" ..\stdout.log
cd ..
if %_original_config_found% equ true (
	:: Restore the original config file
	del \"%_original_config%\"
	move config.xml.back \"%_original_config%\"
)
" > supertuxkart.bat
chmod +x supertuxkart.bat
echo "#!/bin/sh

supertuxkart.bat \$@ 2>&1
mv stdout.log \$LOG_FILE
" > supertuxkart
chmod +x supertuxkart

rm supertuxkart-0.9.3-win64.exe
