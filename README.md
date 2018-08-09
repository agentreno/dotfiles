# Karl's Dotfiles

## Quickstart

Health warning: don't just run other people's scripts without inspecting them 
for 'added value'. Use my dotfiles at your own risk.

`bash -c "$(wget -qO - https://github.com/agentreno/dotfiles/raw/master/bootstrap.sh)"`

## TODO
0. Add detection for tmux version >= 2.5 and use this for clipboard:
   `bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'`
1. Fix problem if .zshrc already exists
2. Install ngrok with github auth by default
