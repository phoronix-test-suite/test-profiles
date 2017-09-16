#!/bin/sh

tar -xjf blender-2.79-linux-glibc219-x86_64.tar.bz2

unzip -o cycles_benchmark_20160228.zip

echo "#!/bin/bash
cd blender-2.79-linux-glibc219-x86_64

if [[ \$@ =~ .*CUDA.* ]]
then
	COMPUTE_TYPE=\"CUDA\"
elif [[ \$@ =~ .*OPENCL.* ]]
then
	COMPUTE_TYPE=\"OPENCL\"
elif [[ \$@ =~ .*NONE.* ]]
then
	COMPUTE_TYPE=\"NONE\"
else
	COMPUTE_TYPE=\"CUDA\"
fi

echo \"import bpy

bpy.context.user_preferences.addons['cycles'].preferences.compute_device_type = '\$COMPUTE_TYPE'
bpy.ops.wm.save_userpref()\" > setgpu.py

./blender -b --python setgpu.py 

./blender \$@ > \$LOG_FILE 2> /dev/null
rm -f output.test" > blender
chmod +x blender
