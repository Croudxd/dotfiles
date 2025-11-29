#!/usr/bin/env bash

# Kill Polybar if running
if pgrep -x polybar >/dev/null; then
    pkill polybar
else
    # Launch Polybar (replace 'main' with your bar config if different)
    ~/.config/polybar/launch.sh
fi
