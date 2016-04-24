#!/bin/bash

sudo apt-get -y install unzip
sudo -i
cd /srv/www/skeleton.local/htdocs
wget -O rips.zip 'http://downloads.sourceforge.net/project/rips-scanner/rips-0.55.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Frips-scanner%2Ffiles%2F&ts=1460880535&use_mirror=tenet'
unzip rips.zip
mv rips-0.55 rips
cd  rips
rm rips.zip
