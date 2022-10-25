# Karl's Dotfiles

## Quickstart

Health warning: don't just run other people's scripts without inspecting them 
for 'added value'. Use my dotfiles at your own risk.

`bash -c "$(wget -qO - https://github.com/agentreno/dotfiles/raw/master/bootstrap-ansible.sh)"`

## TODO

0. Install krew, ctx and ns plugins, and fzf
1. Move NVM install to playbook
2. Install helm
3. Incorporate gpg key creation and git commit signing
4. Ansible install not changing to zsh from bash
5. Template dotfiles like .zshrc and .gitconfig that need a custom user name / email
6. Fix problem if .zshrc already exists
7. Install ngrok with github auth by default
