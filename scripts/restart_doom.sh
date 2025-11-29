#!/usr/bin/env bash

# Kill the running Emacs daemon cleanly
emacsclient -e '(kill-emacs)' 2>/dev/null

# Wait a moment to ensure it's shut down
sleep 1

# Sync Doom (optional, only needed if you changed init.el/packages.el)
~/.emacs.d/bin/doom sync

# Start a fresh daemon
emacs --daemon

echo "Doom Emacs daemon restarted."
