# Karl's Dotfiles

## Quickstart

Health warning: don't just run other people's scripts without inspecting them 
for 'added value'. Use my dotfiles at your own risk.

`bash -c "$(wget -qO - https://github.com/agentreno/dotfiles/raw/master/bootstrap-ansible.sh)"`

## TODO

1. Incorporate gpg key creation and git commit signing
2. Ansible install not changing to zsh from bash
3. Template dotfiles like .zshrc and .gitconfig that need a custom user name / email
4. Fix problem if .zshrc already exists
5. Install ngrok with github auth by default
