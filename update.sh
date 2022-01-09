#!/usr/bin/env bash

if (( $EUID != 0 )); then
   echo "This script must be run as root" 
   exit
fi

RED="\e[0;31m"
GREEN="\e[0;32m"
WHITE="\e[0;97m"
RED_BG="\e[0;41m"
END_COLOR="\e[0m"

_update() {
    clear
    echo -e "${GREEN}[*] Installing system updates. [*]${END_COLOR}"
    sleep 3
    apt update && apt full-upgrade -y && apt autoremove -y && apt clean -y && apt autoclean -y
    echo "${GREEN}[*] System updates complete. [*]${END_COLOR}"
    echo ""
    echo -e "${WHITE}${RED_BG}[!] The system is going to reboot in 5 minutes. [!]${END_COLOR}"
    echo ""
    read -p 'Press [Enter] to continue'
    echo ""
    shutdown --reboot 5
}

_update