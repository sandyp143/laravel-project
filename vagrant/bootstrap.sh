#!/bin/bash

export TERM=xterm
sudo -s

# Setup VirtualHost for Nginx

sudo ln -s /srv/laravel-project/system/nginx/laravel.project.localhost /etc/nginx/sites-enabled/

# Setup Custom PHP ini file for PHP-FPM

sudo rm /etc/php5/fpm/php.ini
sudo ln -s /srv/laravel-project/system/php/fpm/php.ini /etc/php5/fpm/

# Create Database

if [ ! -f /var/log/projectdatabase ];
then
    echo "CREATE USER 'vagrant'@'localhost' IDENTIFIED BY 'vagrant'" | mysql -uhomestead -psecret
    echo "CREATE DATABASE test_database" | mysql -uhomestead -psecret
    echo "GRANT ALL ON test_database.* TO 'vagrant'@'localhost'" | mysql -uhomestead -psecret
    echo "flush privileges" | mysql -uhomestead -psecret
    touch /var/log/projectdatabase
fi

# phpUnit 
sudo apt-get update
sudo apt-get -y install php-pear
sudo pear channel-update pear.php.net
sudo pear upgrade-all
sudo pear config-set auto_discover 1
sudo pear install pear.phpunit.de/PHPUnit
sudo apt-get -y install make
sudo apt-get -y install php5-xdebug
#phpUnit 

# Run Migrations

# Run Seeders

# Restart Services

sudo service php5-fpm restart
sudo service nginx restart