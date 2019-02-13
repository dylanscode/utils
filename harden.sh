#!/bin/bash

# all of this is cribbed from https://www.codelitt.com/blog/my-first-10-minutes-on-a-server-primer-for-securing-ubuntu/

# knock knock housekeeping
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y

# install a firewall and do some basic smart things
sudo sed -i s/IPV6=no/IPV6=yes/g /etc/default/ufw
sudo apt install ufw
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
#sudo ufw allow 53 # i believe this is necessary for AWS
#sudo ufw allow 68 # i believe this is also necessary for AWS

# install fail2ban and just let it do its thing
sudo apt install fail2ban -y

# restart the firewall (will temporarily disable ssh, so logging out now)
sudo ufw disable && sudo ufw --force enable
