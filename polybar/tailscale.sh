#!/bin/bash

# check if tailscale is running
if /usr/bin/tailscale status 2>&1 | grep -q "running"; then
    icon=""  # guaranteed glyph in all Nerd Fonts
    host=$(/usr/bin/tailscale status --json | /usr/bin/jq -r .Self.HostName)
    echo "$icon $host"
else
    echo ""  # guaranteed glyph
fi
