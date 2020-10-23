#!/bin/bash

# LZ1GSP 24/10/2020

################################################
#	This script is created by LZ1GSP for   #
#	automatic installation of DVswitch     #
#	24.10.2020 Sofia,BULGARIA	       #
################################################

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo 
echo 
echo  -e "${GREEN}          This script will install DVSwitch${NC}"
echo -e "${RED}==========================================================
=   Do You want to download DVswitch repo from GITHUB?   =
==========================================================${NC}" 
echo 
read -p "Press Y to continue or N to exit" -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

sudo wget http://dvswitch.org/install-dvswitch-repo

echo -e "${GREEN}
  
==========================================
=   DVswitch repo have been downloaded   =
==========================================${NC}"
echo 
echo -e "${RED}Do You want to install DVswitch?${NC}" 
echo  
read -p "Press Y to begin installation of DVswitch or N to exit" -n 1 -r
echo 
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    exit 1
fi

sudo chmod +x install-dvswitch-repo
echo 
echo DVswitch installation begin. Please wait...
echo ===========================================
echo 
sudo ./install-dvswitch-repo
sudo apt-get install -y dvswitch

sudo rm -r /opt/Analog_Bridge/Analog_Bridge.ini
sudo cd /opt/Analog_Bridge/
sudo git clone https://github.com/DVSwitch/Analog_Bridge/blob/master/Analog_Bridge.ini

echo Enabling and starting services...
echo
sudo systemctl enable systemd-networkd-wait-online.service
sudo systemctl enable analog_bridge
sudo systemctl enable mmdvm_bridge
sudo systemctl enable md380-emu

sudo systemctl start systemd-networkd-wait-online.service
sudo systemctl start analog_bridge
sudo systemctl start mmdvm_bridge
sudo systemctl start md380-emu

sudo systemctl status analog_bridge
sudo systemctl status mmdvm_bridge
sudo systemctl status md380-emu


echo 
echo -e "${GREEN}

================================================
=                                              =
=   DVswitch have been successfuly installed   =
=                                              =
================================================${NC}"
echo 
echo 73 de LZ1GSP/George
echo 
