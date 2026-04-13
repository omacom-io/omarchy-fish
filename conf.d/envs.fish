set -gx SUDO_EDITOR "$EDITOR"
set -gx BAT_THEME ansi
set -g fish_greeting

# History configuration - match bash HISTSIZE
set -g fish_history_max_size 32768

# fzf configuration - use default layout (opens above prompt)
set -gx FZF_DEFAULT_OPTS '--cycle --layout=default --height=90% --preview-window=wrap --marker="*"'

# Ensure fzf history search shows preview (empty to not override the built-in preview)
set -gx fzf_history_opts
