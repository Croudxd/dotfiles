#!/bin/bash

# Set DISPLAY explicitly (usually :0 on first monitor)
export DISPLAY=:0

# Make sure dbus is running
if ! pgrep -u "$USER" dbus-daemon > /dev/null; then
    eval "$(dbus-launch --sh-syntax)"
fi

sleep 1

# Start the portals
/usr/lib/xdg-desktop-portal &
sleep 1
/usr/lib/xdg-desktop-portal-gtk &
