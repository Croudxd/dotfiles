#!/bin/bash

# Default laptop
xrandr --output eDP-1 --auto

# If external monitor exists
if xrandr | grep -q "^HDMI-A-0 connected"; then
    xrandr --output HDMI-A-0 --mode 1920x1080 --rate 60 --above eDP-1

    # Assign workspaces
    i3-msg "workspace 3; move workspace to output HDMI-A-0"
    i3-msg "workspace 4; move workspace to output HDMI-A-0"
fi

# Laptop workspaces
i3-msg "workspace 1; move workspace to output eDP-1"
i3-msg "workspace 2; move workspace to output eDP-1"
