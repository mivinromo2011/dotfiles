#! /usr/bin/env bash

function tmux_sessions()
{
    tmux list-session -F '#S'
}

export $TERMINAL=termite

TMUX_SESSION=$( (echo new; tmux_sessions) | rofi -dmenu -p "Select tmux session")

if [[ x"new" = x"${TMUX_SESSION}" ]]; then
    termite -e tmux new-session &
elif [[ -z "${TMUX_SESSION}" ]]; then
    echo "Cancel"
else
    termite -e tmux attach -t "${TMUX_SESSION}" &
fi