#!/bin/sh
# add new user bruce
sudo adduser bruce
sudo usermod -aG sudo bruce

# delete parallels user
sudo deluser --remove-home parallels
