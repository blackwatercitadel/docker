#!/usr/bin/env bash

if (( $EUID != 0 )); then
   echo "This script must be run as root" 
   exit
fi

IP_ADDR=$(hostname -I | awk '{ print $1 }')

_update_system() {
    echo "[*] Installing system updates. [*]"
    sleep 3
    apt update && apt full-upgrade -y && apt autoremove -y && apt clean -y && apt autoclean -y
    echo "[*] System updates complete. [*]"
}

_prerequisites() {
  if ! command -v curl &>/dev/null; then
    echo "[x] curl is not installed. [x]"
    sleep 3
    apt install curl
    echo "[*] curl installed"
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
    usermod -aG docker $USER
    echo "[*] Docker installed. [*]"
}

_install_docker_compose() {
    echo "[*] Installing Docker Compose. [*]"
    sleep 3
    curl -sL https://api.github.com/repos/$1/releases/latest | grep '"tag_name":' | cut -d'"' -f4
    COMPOSE_LATEST_VERSION=$(get_latest_release "docker/compose")
    echo "[!] Docker Compose latest version: $COMPOSE_LATEST_VERSION [!]"
    mkdir -p /usr/lib/docker/cli-plugins/
    curl -SL https://github.com/docker/compose/releases/download/$COMPOSE_LATEST_VERSION/docker-compose-linux-x86_64 -o /usr/lib/docker/cli-plugins/docker-compose
    chmod +x /usr/lib/docker/cli-plugins/docker-compose
    echo "[*] Docker Compose $COMPOSE_LATEST_VERSION installed. [*]"
}

_install_portainer() {
    echo "[*] Installing Portainer. [*]"
    sleep 3
    docker volume create portainer_data
    docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data cr.portainer.io/portainer/portainer-ce:latest
    echo "[*] Portainer installed. [*]"
}

_update_system
sleep 3
clear
_prerequisites
sleep 3
clear
_install_docker
sleep 3
clear
_install_docker_compose
sleep 3
clear
_install_portainer
sleep 3
clear
echo "Your new Docker server is up and running!

You can use docker -v && docker compose version to verify the installation.

You can now access the following services:
_______________________________________________________________________
Portainer: http://$IP_ADDR:8000 - Docker Management User Interface

"
read -p 'Press [Enter] to continue'
