#!/bin/bash

cd /home/vagrant/

wget -O composer-setup.php https://getcomposer.org/installer
php composer-setup.php
php -r "unlink('composer-setup.php');"
