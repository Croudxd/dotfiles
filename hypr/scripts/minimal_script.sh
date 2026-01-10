#!/bin/bash

# Check if borders are currently active (assuming 2 is your default)
STATUS=$(hyprctl getoption general:border_size | grep "int" | awk '{print $2}')

if [ "$STATUS" -ne 0 ]; then
    # ENTER MINIMAL MODE
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
    hyprctl keyword general:border_size 0
    pkill -SIGUSR1 waybar # Hides waybar without killing the process
else
    # EXIT MINIMAL MODE (Reset to your preferred defaults)
    hyprctl keyword general:gaps_in 5
    hyprctl keyword general:gaps_out 10
    hyprctl keyword general:border_size 2
    pkill -SIGUSR1 waybar # Brings waybar back
fi
