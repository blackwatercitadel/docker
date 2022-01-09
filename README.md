# Docker Server

Install Docker and Portainer in just a few seconds.

## Installation

Clone this repo and make the scripts executable:

  `sudo chmod +x install_docker.sh`<br>
  `sudo chmod +x install_portainer.sh`<br>
  `sudo chmod +x update_portainer.sh`<br>
  
*Optional:*
`sudo chmod +x update.sh` _<-this should be run on an initial server build before installing Docker and Portainer. It is RECOMMENDED to setup `unattended-upgrades`, with the option to "blacklist" the Docker and Portainer packages to prevent distruption to a PRODUCTION environment._

To make all the scripts from this repo executable do the following or see above for the individual commands.<br>

`cd /docker`<br>
`find . -name "*.sh" -exec chmod +x {} \;` _<-this will make all the .sh files executable inside the current (docker) directory._

## Usage
Run `sudo ./install_docker.sh` - install Docker and add the current user to the docker usergroup.<br>
Run `sudo ./install_portainer.sh` - install the latest verion of Portainer.<br>
Run `sudo ./update_portainer.sh` - update a currently installed Portainer version to the latest version.<br>

***Optional:*** If you want to fully update your server before installing Docker and Portainer, simply run `sudo ./update.sh` after making it executable. Upon completion of `update.sh` your system will ***reboot*** in 5 minutes. You can cancel the shutdown using the following command: `sudo shutdown -c` and reboot manually.
