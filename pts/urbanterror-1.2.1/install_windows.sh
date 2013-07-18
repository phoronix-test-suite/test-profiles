#!/bin/sh

unzip -o UrbanTerror42_full013.zip

unzip -o urbanterror-42-1.zip
cp autoexec.cfg UrbanTerror42/q3ut4/
mkdir UrbanTerror42/q3ut4/demos/
mv ptsut421.urtdemo UrbanTerror42/q3ut4/demos/

echo "#!/bin/sh
cd UrbanTerror42/
Quake3-UrT.exe \$@
mv q3ut4/qconsole.log \$LOG_FILE" > urbanterror
chmod +x urbanterror
