#!/usr/bin/bash
#----------------------------------------------------------------------------------------------------
#Mouse actions for the block
case $BLOCK_BUTTON in
	1) xdotool key Alt+v ;;
    4) pamixer -i 3 ;;
    5) pamixer -d 3 ;;
esac

#Toggle mute
[[ $(pamixer --get-mute) = "true" ]] && echo -n  && exit
#Display volume
echo 🔊 $(pamixer --get-volume)%;