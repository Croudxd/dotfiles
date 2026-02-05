#!/bin/bash

# $1 is the action (up, down, mute)
# $2 is the type (volume, brightness)

case $1 in
    up)
        if [ "$2" == "volume" ]; then
            pamixer -i 5
        elif [ "$2" == "brightness" ]; then
            brightnessctl set +5%
        fi
        ;;
    down)
        if [ "$2" == "volume" ]; then
            pamixer -d 5
        elif [ "$2" == "brightness" ]; then
            brightnessctl set 5%-
        fi
        ;;
    mute)
        pamixer -t
        ;;
esac

# Send the notification
if [ "$2" == "volume" ]; then
    # Get volume and mute status
    VOL=$(pamixer --get-volume)
    MUTE=$(pamixer --get-mute)
    
    if [ "$MUTE" == "true" ]; then
        dunstify -a "changeVolume" -u low -r 9993 -h string:x-dunst-stack-tag:volume "Volume: Muted" 
    else
        # The -h int:value:$VOL creates the progress bar
        dunstify -a "changeVolume" -u low -r 9993 -h string:x-dunst-stack-tag:volume \
        -h int:value:"$VOL" "Volume: ${VOL}%"
    fi

elif [ "$2" == "brightness" ]; then
    # Get brightness percentage
    BRIGHT=$(brightnessctl -m | cut -d, -f4 | tr -d %)
    
    dunstify -a "changeBrightness" -u low -r 9994 -h string:x-dunst-stack-tag:brightness \
    -h int:value:"$BRIGHT" "Brightness: ${BRIGHT}%"
fi
