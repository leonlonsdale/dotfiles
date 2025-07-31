# Tokyo Night Storm

# === General ===
set -g status on
set -g status-interval 5
set -g status-justify left
set-option -g status-style bg=default
set -g default-terminal "tmux-256color"
set -as terminal-overrides ',xterm-256color:Tc'

# === Window Titles ===
set -g window-status-format ' #[fg=#D3C6AA] #W '        # comment/dim
set -g window-status-current-format '#[bg=default,fg=#DBBC7F,nobold]#[fg=#24283B,bg=#DBBC7F,bold] #W#[fg=#DBBC7F,bg=default,nobold] '
set -g window-status-separator ""
set -g window-status-current-style "fg=#bb9af7,bold"     # purple
set -g window-status-style "fg=#545c7e"                  # comment

# === Pane Borders ===
set -g pane-border-style "fg=#3b4261"                    # border
set -g pane-active-border-style "fg=#DBBC7F"             # blue

# === Messages ===
set -g message-style "fg=#D3C6AA,bg=#1E2326"             # fg on darker bg
set -g message-command-style "fg=#D3C6AA,bg=#1E2326"     # blue on bg_dark

# === Copy Mode ===
# set -g mode-style "fg=#2ac3de,bg=#292e42"

# === Clock ===
# set -g clock-mode-style "fg=#2ac3de,bg=default"

# === Left Status ===
set -g status-left-length 40
set -g status-left '#[fg=#24283B,bg=#7EB98C,bold] 󰈸 #S #[fg=#7EB98C,bg=default,nobold] '

# === Right Status ===
set -g status-right-length 150
set -g status-right '#[fg=#E67E81]#(cd "#{pane_current_path}" && git rev-parse --is-inside-work-tree >/dev/null 2>&1 && echo " $(git rev-parse --abbrev-ref HEAD)") #[fg=#7EB98C,bg=default,nobold]#[fg=#24283B,bg=#7EB98C,bold] %d/%m #[fg=#24283B,bg=#7FBBB3,bold]  %H:%M #[fg=#7FBBB3,bg=default,nobold] '
