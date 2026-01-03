#!/bin/bash

handle() {
    if [[ "$1" == openwindow* ]]; then
        # Format: openwindow>>ADDRESS,WORKSPACEID,CLASS,TITLE
        data="${1#openwindow>>}"
        ws=$(echo "$data" | cut -d',' -f2)
        if [[ "$ws" == "1" ]]; then
            sleep 0.1
            /home/maxy/.config/hypr/cascade-resize.sh
        fi
    fi
}

socat -U - UNIX-CONNECT:"$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock" | while read -r line; do
    handle "$line"
done