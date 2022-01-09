# Docker Server

Install Docker and Portainer in just a few seconds.

## Installation

Clone this repo and make the scripts executable:

  `sudo chmod +x install_docker.sh`<br>
  `sudo chmod +x install_portainer.sh`<br>
  `sudo chmod +x update_portainer.sh`<br>
  
*Optional:*
`sudo chmod +x update.sh`

## Usage
Run `sudo ./install_docker.sh` - to install Docker and add the current user to the docker usergroup.<br>
Run `sudo ./install_portainer.sh` - to install the latest verion of Portainer.<br>
Run `sudo ./update_portainer.sh` - to update Portainer to the latest version.<br>

***Optional:*** If you want to fully update your server before installing Docker and Portainer, simply run `sudo ./update.sh` after making it executable. Upon completion of `update.sh` your system will ***reboot*** in 5 minutes. You can cancel the shutdown using the following command: `shutdown -c` and reboot manually.
