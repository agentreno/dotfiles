# Karl's Dotfiles

## Quickstart

Health warning: don't just run other people's scripts without inspecting them 
for 'added value'. Use my dotfiles at your own risk.

`bash -c "$(wget -qO - https://github.com/agentreno/dotfiles/raw/master/bootstrap-ansible.sh)"`

## TODO
1. Ansible install not changing to zsh from bash
1. Template dotfiles like .zshrc that need a custom user name
2. Add detection for tmux version >= 2.5 and use this for clipboard:
   `bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'`
3. Fix problem if .zshrc already exists
4. Install ngrok with github auth by default
