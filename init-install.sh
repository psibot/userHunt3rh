#!/bin/bash
# SCRIPT:
# REV: Version 1.0
# PLATFORM: Linux
# AUTHOR: Coenraad
#
# PURPOSE: Install userHunt3r
#
##########################################################
########### DEFINE FILES AND VARIABLES HERE ##############
##########################################################
# Run as root.
if [[ $EUID -ne 0 ]]; then
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    exit 1
fi

clear

##########################################################
################ BEGINNING OF MAIN #######################
##########################################################
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing Need Repo's and software!!! This will take TIME..  \e[0m"
    echo
    echo "Installing system"
    echo
apt update
apt install tor git terminator python3 python3-pip
# Git get needed software
#pwndb
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing pwndb \e[0m"
    echo
git clone https://github.com/davidtavarez/pwndb.git
cd pwndb
pip3 install -r requirements.txt
cd ..
#userrecon
  echo
  echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing UserRecon \e[0m"
  echo
git clone https://github.com/stjordanis/userrecon-py.git; cd userrecon-py
sudo -H pip3 install -r requirements.txt
python3 setup.py build
sudo python3 setup.py install
cd ..
#Sherlock
  echo
  echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Installing Sherlock  \e[0m"
  echo
git clone https://github.com/sherlock-project/sherlock.git
cd sherlock
python3 -m pip install -r requirements.txt
cd ..



####################################################
################ END OF MAIN #######################
####################################################
exit 0
# End of script
