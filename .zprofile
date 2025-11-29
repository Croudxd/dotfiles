# Start Emacs daemon in background if not running
if ! pgrep -x "emacs" >/dev/null 2>&1; then
    emacs --daemon >/dev/null 2>&1 &
fi
