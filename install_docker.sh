#!/usr/bin/env bash

if (( $EUID != 0 )); then
   echo "This script must be run as root" 
   exit
fi

_error() {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

RED="\e[0;31m"
GREEN="\e[0;32m"
WHITE="\e[0;97m"
RED_BG="\e[0;41m"
END_COLOR="\e[0m"

_prerequisites() {
  if ! command -v curl &>/dev/null; then
    echo -e "${GREEN}[!] Installing curl. [!]${END_COLOR}"
    sleep 3
    apt install curl
    echo -e "${GREEN}[*] curl is now installed. [*]${END_COLOR}"
    sleep 3
    return 1
  fi
  return 0
}

_install_docker() {
    clear
    echo -e "${GREEN}[*] Installing Docker. [*]${END_COLOR}"
    sleep 3
    curl -fsSL https://get.docker.com -o get-docker.sh | sh
    sh get-docker.sh
    rm get-docker.sh
    usermod -aG docker $USER || _error "[!] Failed to add user to docker group [!]"
    echo -e "${GREEN}[*] Docker installed successfully. [*]${END_COLOR}"
    echo ""
    echo -e "${WHITE}${RED_BG}[!] The system is going to reboot in 2 minutes for the changes to take effect. [!]${END_COLOR}"
    echo ""
    read -p 'Press [Enter] to continue'
    echo ""
    shutdown --reboot 2
}

_prerequisites
_install_docker