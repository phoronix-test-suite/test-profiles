#!/bin/bash
chmod +x mistral-7b-instruct-v0.2.Q5_K_M.llamafile.86
chmod +x llava-v1.6-mistral-7b.Q8_0.llamafile.86
chmod +x wizardcoder-python-34b-v1.0.Q6_K.llamafile.86
chmod +x Meta-Llama-3-8B-Instruct.F16.llamafile.86
chmod +x TinyLlama-1.1B-Chat-v1.0.BF16.llamafile.86
tar -xf pts-sample-photos-2.tar.bz2
echo $? > ~/install-exit-status

cat <<'EOT' > run-mistral
#!/bin/bash
./mistral-7b-instruct-v0.2.Q5_K_M.llamafile.86 --temp 0.7 -p '[INST]Write a long story about llamas[/INST]' $@
exit $?
EOT
chmod +x run-mistral

cat <<'EOT' > run-llama3
#!/bin/bash
./Meta-Llama-3-8B-Instruct.F16.llamafile.86 --temp 0.7 -p '[INST]Write a long story about llamas[/INST]' $@
exit $?
EOT
chmod +x run-llama3

cat <<'EOT' > run-tinyllama
#!/bin/bash
./TinyLlama-1.1B-Chat-v1.0.BF16.llamafile.86 --temp 0.7 -p '[INST]Write a long story about llamas[/INST]' $@
exit $?
EOT
chmod +x run-tinyllama

cat <<'EOT' > run-wizardcoder
#!/bin/bash
./wizardcoder-python-34b-v1.0.Q6_K.llamafile.86 --temp 0 -e -r '```\n' -p '```c\nvoid *memcpy_sse2(char *dst, const char *src, size_t size) {\n' $@
exit $?
EOT
chmod +x run-wizardcoder

cat <<'EOT' > run-llava
#!/bin/bash
./llava-v1.6-mistral-7b.Q8_0.llamafile.86 --temp 0.2 --image DSC_4646.JPG -e -p '### User: Describe in detail what do you see?\n### Assistant:' $@
exit $?
EOT
chmod +x run-llava

echo "#!/bin/sh
./\$@ -t \$NUM_CPU_PHYSICAL_CORES > \$LOG_FILE 2>&1
echo \$? > ~/test-exit-status" > ~/llamafile
chmod +x ~/llamafile
