#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y software-properties-common wget
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install -y ansible

wget https://github.com/agentreno/dotfiles/raw/master/playbook.yml

if [ "$1" == "test" ]; then
    ansible-playbook -e git_email=test@test.com -e user_password=test playbook.yml
else
    ansible-playbook playbook.yml
fi
