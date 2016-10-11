#!/bin/bash
mkdir -p /var/www/example.com/html/ /var/www/example.com/logs/

echo $USER
echo "THE USER IS $USER!"
adduser nobody
sudo chown -R nobody:nobody /var/www/example.com/html
sudo chmod 755 /var/www

echo "THE USER IS STILL $USER"

groupadd www # > /dev/null 2>&1
usermod -aG www $USER # > /dev/null 2>&1

#chown -R $USER:$USER /var/www/html





