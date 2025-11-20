#!/bin/bash
level=$(cat /sys/class/power_supply/BAT0/capacity)
status=$(cat /sys/class/power_supply/BAT0/status)

if [ "$status" = "Charging" ]; then
    icon=""
elif [ "$level" -ge 90 ]; then
    icon=""
elif [ "$level" -ge 70 ]; then
    icon=""
elif [ "$level" -ge 50 ]; then
    icon=""
elif [ "$level" -ge 20 ]; then
    icon=""
else
    icon=""
fi

echo "$icon $level%"
