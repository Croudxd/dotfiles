source ~/.zshrc.d/rc
bindkey -v

# Move by word with Ctrl+Left/Right while typing at the zsh prompt.
# xterm-compatible terminals and tmux commonly use the first pair; the
# second pair covers older terminal escape sequences.
bindkey -M viins '^[[1;5D' backward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M viins '^[[5D' backward-word
bindkey -M viins '^[[5C' forward-word

# uv tool install / pip --user land here; needed for ruff, basedpyright, etc.
export PATH="$HOME/.local/bin:$PATH"
