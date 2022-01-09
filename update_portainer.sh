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

_update_portainer() {
    clear
    echo -e "${GREEN}[*] Updating Portainer. [*]${END_COLOR}"
    portainer_pid=`docker ps | grep portainer-ce | awk '{print $1}'`
    portainer_name=`docker ps | grep portainer-ce | awk '{print $2}'`
    docker stop $portainer_pid || _error "[!] Failed to stop portainer [!]"
    docker rm $portainer_pid || _error "[!] Failed to remove portainer container [!]"
    docker rmi $portainer_name || _error "[!] Failed to remove/untag images from the container [!]"
    apt update
    docker run -d -p 8000:8000 -p 9443:9443 --name=portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:latest || _error "[!] Failed to execute newer version of Portainer [!]"
    echo -e "${GREEN}[*] Portainer updated. [*]${END_COLOR}"
    echo ""
    echo -e "${GREEN}You can now access Portainer as shown below:
    _______________________________________________________________________
    Portainer: https://$IP_ADDR:9443 - Docker Management User Interface${END_COLOR}"
    echo ""
    read -p 'Press [Enter] to continue'
}

_update_portainer