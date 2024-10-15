#!/bin/sh
tar -xf litert-20241015.tar.xz
tar -xf mobilenet_v1_1.0_224.tgz
tar -xf mobilenet_v1_1.0_224_quant.tgz
tar -xf nasnet_mobile_2018_04_27.tgz
tar -xf squeezenet_2018_04_27.tgz
tar -xf inception_resnet_v2_2018_04_27.tgz
tar -xf inception_v4_2018_04_27.tgz
unzip -o coco_ssd_mobilenet_v1_1.0_quant_2018_06_29.zip
echo "#!/bin/sh
if [ \$OS_ARCH = \"aarch64\" ]
then
	./linux_aarch64_benchmark_model --num_threads=\$NUM_CPU_CORES \$@ > \$LOG_FILE 2>&1
else
	./linux_x86-64_benchmark_model --num_threads=\$NUM_CPU_CORES \$@ > \$LOG_FILE 2>&1
fi
echo \$? > ~/test-exit-status" > litert
chmod +x litert
