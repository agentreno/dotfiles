#!/usr/bin/env bash

# Pre dotfiles script that doesn't assume the presence of git or a registered 
# SSH key

# Setup a new SSH key for Github
cd ~/.ssh
while true; do
    read -p "What email should be used for a new SSH key? " keyemail
    if [[ -n "$keyemail" ]]; then break; fi
done

ssh-keygen -t rsa -b 4096 -C $keyemail
echo "The default key is: "
cat ~/.ssh/id_rsa.pub
echo "Copy this and register it on Github as a new key, then press any key"
read
cd ~

# Install git
sudo apt-get update
sudo apt-get install -y git

# Clone dotfiles
git clone git@github.com:agentreno/dotfiles

# Prompt to start dotfiles installation
while true; do
    read -p "Do you want to install dotfiles? " yn
    case $yn in
        [Yy]* ) cd dotfiles; ./install.sh; break;;
        [Nn]* ) echo "Finished";;
        * ) echo "Please answer yes or no";;
    esac
done
