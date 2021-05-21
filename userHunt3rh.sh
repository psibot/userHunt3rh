#!/bin/bash
# SCRIPT: userHunt3rh.sh
# REV: Version 1.0
# PLATFORM: Linux
# AUTHOR: Coenraad
#
# PURPOSE: userHunt3r control
#
##########################################################
########### DEFINE FILES AND VARIABLES HERE ##############
##########################################################

##########################################################
################ BEGINNING OF MAIN #######################
##########################################################
# Run as root.
if [[ $EUID -ne 0 ]]; then
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    echo -e "\e[1mMust be ROOT to run  this script!\e[0m"
    exit 1
fi

clear

function install()
{
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Kick off INSTALL \e[0m"
    echo
    echo "Build system"
    echo
    sudo ./init-install.sh
    echo
    echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m INSTALL DONE \e[0m"

  }

function userattack()
  {
      clear
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Starting ATTACK !!!  \e[0m"
      echo
      echo "Please always be safe"
      read -p "Press [Enter] Be shure!!!..."
      service tor start
      service tor status
      echo
      # User input:
      echo
      echo -e "\e[40;38;5;82m  [-] \e[30;48;5;82m Setup User account for ATTACK !!!  \e[0m"
      sleep 2s
      echo
      echo "Please enter username : "
      read useracc
      python3 pwndb/pwndb.py --target $useracc
      echo
      read -p "Press [Enter] to continue..."
      echo
      userrecon-py target $useracc
      echo 
      read -p "Press [Enter] to continue..."
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m  Sherlock TAKES TIME  \e[0m"
      echo
      read -p "Press [Enter] to continue..."
      python3 sherlock/sherlock/sherlock.py  $useracc
      sleep 5
      read -p "Press [Enter] to continue..."
      echo 

    }

function domianattack()
 {
      clear
      echo
      echo -e "\e[40;38;5;82m [+] \e[30;48;5;82m Starting ATTACK !!!  \e[0m"
      echo
      echo "Please always be safe"
      read -p "Press [Enter] Be shure!!!..."
      service tor start
      service tor status
      echo
      # User input:
      echo
      echo -e "\e[40;38;5;82m  [-] \e[30;48;5;82m  Domain Emails Leaked  !!!  \e[0m"
      sleep 2s
      echo
      echo "Please enter Domain : example @gmail.com "
      read domacc
      python3 pwndb/pwndb.py --target $domacc
      echo
      read -p "Press [Enter] to continue..."
      echo
 }


function show_menus()
  {
  clear

  echo

  echo -e "Hello to \e[5muserHunt3r \e[0m"
  echo -e "\e[31m[-]\e[0m \e[1m   Choose : Hit 'a' for !!! WILL INSTALL SYSTEM * RUN ME FIRST !!! \e[0m"
  echo -e "\e[31m[-]\e[0m \e[1m   Choose : Hit 'b' for Setup FULL Account for ATTACK !!!\e[0m"
  echo -e "\e[31m[-]\e[0m \e[1m   Choose : Hit 'c' for Check DOMAINS for leaked accounts !!!\e[0m"
  echo -e "\e[31m[-]\e[0m \e[1m   Choose : Hit 'x' for Exit!!!\e[0m"
  echo
  echo "Pick Option:"
  }


  show_menus

  read choice
  if [ "$choice" == a ]; then
      install
      show_menus
      read choice
      fi

  if [ "$choice" == b ]; then
      userattack
      clear
      sleep 2
      echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m THANK YOU FOR USING ME !!!  \e[0m"
      echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m Have a nice day! \e[0m"
      exit 0
      fi
  
      if [ "$choice" == c ]; then
      domianattack
      clear
      sleep 2
      echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m THANK YOU FOR USING ME !!!  \e[0m"
      echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m Have a nice day! \e[0m"
      exit 0
      fi

  if [ "$choice" == x ]; then
      clear
      sleep 2
      echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m THANK YOU FOR USING ME !!!  \e[0m"
      echo -e "\e[40;38;5;82m [*] \e[30;48;5;82m Have a nice day! \e[0m"
      exit 0
      fi


####################################################
################ END OF MAIN #######################
####################################################
exit 0
# End of script
