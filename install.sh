#!/usr/bin/env bash

# Get the current directory of this script wherever it was executed from
export DOTFILES_DIR
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Function to simplify running git outside of the repo directory
function git-alt(){
   local _dir="$1";
   shift;
   git --git-dir="${_dir}/.git" --work-tree="${_dir}" "$@"
}

# Function to highlight status updates from the script
function report(){
   tput bold;
   echo "$@";
   tput sgr0
}

# Install curl
sudo apt-get -y install curl

# Update dotfiles itself and all of it's submodules
report "Updating dotfiles and submodules"
[ -d "$DOTFILES_DIR/.git" ] && git-alt $DOTFILES_DIR pull origin master
pushd $DOTFILES_DIR > /dev/null
git submodule update --init --recursive
popd > /dev/null

# Vim Setup
# Rename any existing vimrc's or .vim/
sudo apt-get -y install vim
if [ -d ~/.vim ];
then
   report "Found existing ~/.vim folder, renaming to ~/.vimbak"
   mv ~/.vim ~/.vimbak
fi

if [ -f ~/.vimrc ];
then
   report "Found existing ~/.vimrc file, renaming to ~/.vimrcbak"
   mv ~/.vimrc ~/.vimrcbak
fi

# Link folder and config file
report "Linking vim configuration files"
ln -sfv "$DOTFILES_DIR/vimfiles/vimrc" ~/.vimrc
ln -sfv "$DOTFILES_DIR/vimfiles" ~/.vim

# Tmux Setup
report "Linking tmux config"
sudo apt-get -y install tmux
ln -sfv "$DOTFILES_DIR/.tmux.conf" ~/.tmux.conf

# Git Setup
report "Linking git config"
ln -sfv "$DOTFILES_DIR/.gitconfig" ~/.gitconfig
report "Installing hub"
wget https://github.com/github/hub/releases/download/v2.2.3/hub-linux-amd64-2.2.3.tgz
tar -xvf hub-linux-amd64-2.2.3.tgz
sudo ./hub-linux-amd64-2.2.3/install
rm -rf hub-linux-amd64-2.2.3
rm -rf hub-linux-amd64-2.2.3.tgz

# Install Python
sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
    libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
    xz-utils tk-dev libffi-dev liblzma-dev
curl -L https://github.com/pyenv/pyenv-installer/raw/master/bin/pyenv-installer | bash
sh -c $DOTFILES_DIR/setup_pyenv.sh

# Install flake8 config
mkdir ~/.config
ln -sfv "$DOTFILES_DIR/.flake8" ~/.config/flake8

# Install Node
report "Installing Node 4.5.0"
curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
sudo apt-get -y install nodejs
sudo ln -sfv /usr/bin/nodejs /usr/bin/node

# Install xclip
sudo apt-get -y install xclip

# Install awless
curl https://raw.githubusercontent.com/wallix/awless/master/getawless.sh | bash
sudo mv awless /usr/local/bin

# Optionally start work dotfiles setup
function get-work-dotfiles() {
   git clone git@github.com:ButoVideo/workdotfiles
   cd workdotfiles
   ./install.sh
}

while true; do
   read -p "Do you want to install work dotfiles? " yn
   case $yn in
      [Yy]* ) report "Installing workdotfiles"; get-work-dotfiles; break;;
      [Nn]* ) report "Continuing without work dotfiles"; break;;
      * ) echo "Please answer yes or no";;
   esac
done

if [ "$(git config --global --get user.email)" == "" ]; then
   read -p "What email address do you want to use for git commits? " gitemail
   git config --global user.email $gitemail
fi

# LAST STEP! Zsh and oh-my-zsh Setup
ln -sdv "$DOTFILES_DIR/.zshrc" ~/.zshrc
sudo apt-get -y install zsh
sh -c $DOTFILES_DIR/install-oh-my-zsh.sh
