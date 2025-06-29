#!/bin/sh

# Get volume from wpctl
volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
muted=$(echo "$volume" | grep -q "[MUTED]" && echo "yes" || echo "no")
volume=$(echo "$volume" | awk '{print $2}')
volume=$(echo "( $volume * 100 ) / 1" | bc)

# Determine Freedesktop icon based on volume level or muted state
if [ "$muted" = "yes" ]; then
    icon="/home/maxy/.config/mako/icons/audio-volume-muted-symbolic.png"
elif [ "$volume" -eq 0 ]; then
    icon="/home/maxy/.config/mako/icons/audio-volume-muted-symbolic.png"
elif [ "$volume" -le 30 ]; then
    icon="/home/maxy/.config/mako/icons/audio-volume-low-symbolic.png"
elif [ "$volume" -le 70 ]; then
    icon="/home/maxy/.config/mako/icons/audio-volume-medium-symbolic.png"
else
    icon="/home/maxy/.config/mako/icons/audio-volume-high-symbolic.png"
fi

# Build notification message
message="Volume: ${volume}%"
if [ "$muted" = "yes" ]; then
    message="$message (Muted)"
fi

# Send notification with Freedesktop icon and progress bar
notify-send -t 1000 -a 'wp-vol' -i "$icon" -h int:value:$volume "$message"