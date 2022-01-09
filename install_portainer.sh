#!/usr/bin/env bash

if (( $EUID != 0 )); then
   echo "This script must be run as root" 
   exit
fi

IP_ADDR=$(hostname -I | awk '{ print $1 }')

_error() {
  echo -e "\\e[91m$1\\e[39m"
  exit 1
}

RED="\e[0;31m"
GREEN="\e[0;32m"
WHITE="\e[0;97m"
RED_BG="\e[0;41m"
END_COLOR="\e[0m"

_install_portainer() {
    clear
    echo -e "${GREEN}[*] Installing Portainer. [*]${END_COLOR}"
    sleep 3
    docker volume create portainer_data || _error "[!] Failed to create volume [!]"
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data cr.portainer.io/portainer/portainer-ce:latest || _error "[!] Failed to run Portainer [!]"
    echo -e "${GREEN}[*] Portainer installed. [*]${END_COLOR}"
    echo ""
    echo -e "${GREEN}You can now access Portainer as shown below:
    _______________________________________________________________________
    Portainer: https://$IP_ADDR:9443 - Docker Management User Interface${END_COLOR}"
    echo ""
    read -p 'Press [Enter] to continue'
}

_install_portainer