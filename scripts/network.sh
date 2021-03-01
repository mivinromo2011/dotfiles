#!/usr/bin/bash

iface=$(ip route | grep default | cut -f5 -d" ");

if [[ "$iface"=="wlo1" ]]; then
	if [[ $(iw wlo1 info | grep ssid) ]]; then
		echo "  $(iw wlo1 info | awk '/ssid/ {$1=""; print $0}')";
	else
		if [[ $(ip route | grep default) ]]; then
			echo "  Wired";
		else
			echo "  Disconnected";
		fi
	fi
fi