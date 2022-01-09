#!/usr/bin/env bash

if (( $EUID != 0 )); then
   echo "This script must be run as root" 
   exit
fi

_update() {
    echo "[*] Installing system updates. [*]"
    sleep 3
    apt update && apt full-upgrade -y && apt autoremove -y && apt clean -y && apt autoclean -y
    echo "[*] System updates complete. [*]
    
    "
    read -p 'Press [Enter] to continue'
}

_update