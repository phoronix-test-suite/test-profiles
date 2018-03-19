#!/bin/sh

echo "#PHOROSCRIPT
winsat \$@ -v -xml \$LOG_FILE" > winsat
chmod +x winsat
