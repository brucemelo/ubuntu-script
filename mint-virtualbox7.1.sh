#!/bin/sh
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian $(grep 'UBUNTU_CODENAME' /etc/os-release | cut -d'=' -f2) contrib" | sudo tee /etc/apt/sources.list.d/virtualbox.list
sudo wget -O- https://www.virtualbox.org/download/oracle_vbox_2016.asc | sudo gpg --yes --output /usr/share/keyrings/oracle-virtualbox-2016.gpg --dearmor
sudo apt-get update
sudo apt-get install -y virtualbox-7.1