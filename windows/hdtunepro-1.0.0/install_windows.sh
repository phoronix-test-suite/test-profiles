#!/bin/sh

/cygdrive/c/Windows/system32/cmd.exe /c hdtunepro_570_trial.exe /install
/cygdrive/c/Windows/system32/cmd.exe /c hdtunepro_570_full.exe /install

echo "This test profile requires an HD Tune Pro license for command-line automation. Before running this test make sure you activate/register your installation. If using the trial version of the software, you need to manually hit the Okay button at launch and will only work for 15 days." > ~/install-message

echo "#!/bin/bash
cd \"C:\Program Files (x86)\HD Tune Pro\"
/cygdrive/c/Windows/system32/cmd.exe /c HDTunePro.exe \$@ /START /QUIT /LOG:\$LOG_FILE" > hdtunepro
chmod +x hdtunepro

