#!/bin/bash


sudo apt update
sudo apt install -y python3.5 build-essential libssl-dev libffi-dev python3.5-dev python3-pip python3-ndg-httpsclient
sudo pip3 install -U pip setuptools
sudo pip3 install pyOpenSSL==19.1.0
sudo pip3 install ansible==2.9.9
