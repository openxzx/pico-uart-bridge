#!/bin/bash

set -e

echo -e "\033[0;32mStart flash u2f.....\033[0m"

# Checking input parameter
if [ -z $1 ]; then
	stty -F /dev/ttyACM0 1200
else
	stty -F $1 1200
fi
sleep 5
echo "Board into BOOTSEL mode."

# Copy u2f to board, retry for 5
for i in {1..5}
do
	storage=`mount | grep "RPI-RP2" | awk '{ print $1 }'`
	if [ -z $storage ]; then
		sleep 1
	else
		cp build/uart_bridge.uf2 $storage
		break
	fi
done

echo -e "\033[0;32mFlash u2f Done.\033[0m"
