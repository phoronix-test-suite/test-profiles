#!/bin/sh

unzip -o S-master-20180121.zip

echo "#!/bin/sh

if [ \"\$1\" = \"r\" ]; then
	mix=\"10 0\"
else
	mix=\"5 5\"
fi

case \$2 in
gnome-terminal)
	comm=\"gnome-terminal -e /bin/true\"
;;
xterm)
	comm=\"xterm /bin/true\"
;;
lowriter)
	comm=\"lowriter --terminate_after_init\"
;;
esac

mylog=$(pwd)/tmplog 
cd S-master/comm_startup_lat
./comm_startup_lat.sh \"\" \$mix seq 3 \"\$comm\" >> \$mylog
egrep \"Latency statistics\" -A 2 \$mylog | tail -n 1 | awk \"{ printf \\\"Average start-up time: %g\\n\\\",  \\\$3 }\" | tail -n 1 > \$LOG_FILE
rm \$mylog
" > startuptime-run
chmod +x startuptime-run

