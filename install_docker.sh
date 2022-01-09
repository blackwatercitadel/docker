#!/usr/bin/env bash

if (( $EUID != 0 )); then
   echo "This script must be run as root" 
   exit
fi

_error() {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

_prerequisites() {
  if ! command -v curl &>/dev/null; then
    echo "[x] Installing curl. [x]"
    sleep 3
    apt install curl
    echo "[*] curl is now installed. [*]"
    sleep 3
    return 1
  fi
  return 0
}

_install_docker() {
    echo "[*] Installing Docker. [*]"
    sleep 3
    curl -fsSL https://get.docker.com -o get-docker.sh | sh
    sh get-docker.sh
    rm get-docker.sh
    usermod -aG docker $USER || _error "[!] Failed to add user to docker group [!]"
    echo "[*] Docker installed successfully. [*]"
    echo "[!] Remember to logoff/reboot for the changes to take effect. [!]
    
    "
    read -p 'Press [Enter] to continue'
}

_prerequisites
clear
_install_docker