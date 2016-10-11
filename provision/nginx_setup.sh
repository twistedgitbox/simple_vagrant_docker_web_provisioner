#!/bin/bash
# create alternative html and logs directories for future changes
mkdir -p /var/www/example.com/html/ /var/www/example.com/logs/ > /dev/null 2>&1

# Add user nobody in the event you wish to use the standard nginx configuration vs docker nginx
adduser nobody > /dev/null 2>$1
sudo chown -R nobody:nobody /var/www/example.com/html > /dev/null 2>&1
sudo chmod 755 /var/www > dev/null 2>&1

# Add group www for the same reason
groupadd www  > /dev/null 2>&1
usermod -aG www $USER  > /dev/null 2>&1







