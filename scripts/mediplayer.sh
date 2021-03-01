#!/bin/bash
#----------------------------------------------------------------------------------------------------
# Requires playerctl - https://github.com/acrisci/playerctl
#----------------------------------------------------------------------------------------------------
#Exit the script if no music players running
[[ "$(playerctl status 2>&1)" = "No players found" ]] && exit 33;

# Define cursor icons
playIcon="";
pauseIcon=" ⏸️";
stopIcon=" ⏹️";

#User provided args for playerctl
ARGUMENTS="$INSTANCE";

#Mouse actions for the block
case $BLOCK_BUTTON in
    1) playerctl $ARGUMENTS play-pause ;;
esac

#Define song info variables
playerStatus=$(playerctl $ARGUMENTS status);
songTitle=$(playerctl $ARGUMENTS metadata title);
songInfo="$songTitle";


#Display output
if [[ "${playerStatus^}" = "Paused" ]]; then
    echo "$songInfo$pauseIcon" && pkill -RTMIN+10 i3blocks;
elif [[ "${playerStatus^}" = "Playing" ]]; then
    echo "$songInfo$playIcon" && pkill -RTMIN+10 i3blocks;
elif [[ "${playerStatus^}" = "Stopped" ]]; then
    echo "Stopped$stopIcon" && pkill -RTMIN+10 i3blocks;
fi