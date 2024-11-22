#!/bin/sh
unzip -o cycles_benchmark_20160228.zip
mv benchmark/bmw27/*.blend ~
mv benchmark/classroom/*.blend ~
mv benchmark/fishy_cat/*.blend ~
mv benchmark/pabellon_barcelona/*.blend ~
BIN_TYPE="x64"
if [ $OS_ARCH = "aarch64" ]
then
	BIN_TYPE="arm64"
fi
echo "#!/bin/bash
[ ! -d /Volumes/Blender/ ] && hdid blender-4.3.0-macos-$BIN_TYPE.dmg
BLEND_ARGS=\$@
if [[ \$@ =~ .*CPU.* ]]
then
	BLEND_ARGS=\${BLEND_ARGS/_gpu/_cpu}
fi
cd benchmark
/Volumes/Blender/Blender.app/Contents/MacOS/Blender \$BLEND_ARGS > \$LOG_FILE
rm -f output.test" > blender
chmod +x blender
