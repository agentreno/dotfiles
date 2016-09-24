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

# Update dotfiles itself and all of it's submodules
report "Updating dotfiles and submodules"
[ -d "$DOTFILES_DIR/.git" ] && git-alt $DOTFILES_DIR pull origin master
pushd $DOTFILES_DIR > /dev/null
git submodule update --init --recursive
popd > /dev/null

# Zsh and oh-my-zsh Setup
sudo apt-get install zsh
chsh -s $(which zsh)
zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Vim Setup
# Rename any existing vimrc's or .vim/
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

# Install the vital stuff
report "Installing Python and Node tools"
sudo apt-get update
sudo apt-get -y install python python3 python-pip python3-pip
sudo apt-get -y install nodejs npm
sudo ln -sfv /usr/bin/nodejs /usr/bin/node

