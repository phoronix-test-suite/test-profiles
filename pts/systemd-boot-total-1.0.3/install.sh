#!/bin/sh

SA=`which systemd-analyze`
echo $? > ~/install-exit-status

cat > systemd-boot-total << EOT
#!/bin/sh

case \$@ in
    total )
	OUTPUT="\$(${SA} |   sed -e 's/in /\n/' -e 's/[+|=] /\n/g' | sed -n '6p'| cut -d' ' -f1)"
	;;
    userspace )
	OUTPUT="\$(${SA} |   sed -e 's/in /\n/' -e 's/[+|=] /\n/g' | sed -n '5p'| cut -d' ' -f1)"
	;;
    kernel )
	OUTPUT="\$(${SA} |   sed -e 's/in /\n/' -e 's/[+|=] /\n/g' | sed -n '4p'| cut -d' ' -f1)"
	;;
    loader )
	OUTPUT="\$(${SA} |   sed -e 's/in /\n/' -e 's/[+|=] /\n/g' | sed -n '3p'| cut -d' ' -f1)"
	;;
    firmware )
	OUTPUT="\$(${SA} |   sed -e 's/in /\n/' -e 's/[+|=] /\n/g' | sed -n '2p'| cut -d' ' -f1)"
	;;
esac

if [[ "\$OUTPUT" =~ "ms" ]];then
	TIME_MS="\$(echo \$OUTPUT | cut -d'm' -f1)"
	echo \$TIME_MS > \$LOG_FILE 2>&1
else
	TIME_SEC="\$(echo \$OUTPUT | cut -d's' -f1)"
	TIME_MS="\$(echo "\$TIME_SEC * 1000" | bc)"
	echo \$TIME_MS > \$LOG_FILE 2>&1
fi
EOT

chmod +x systemd-boot-total
