#!/usr/bin/env bash
sudo apt-get update
sudo apt-get install -y software-properties-common
sudo apt-add-repository -y ppa:ansible/ansible
sudo apt-get update
sudo apt-get install ansible

# TODO: Bootstrap ansible-playbook on the playbook.yml (possibly cloning repo first)