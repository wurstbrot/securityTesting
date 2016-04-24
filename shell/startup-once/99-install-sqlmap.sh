#!/bin/bash

cd /home/vagrant
wget -O sqlmap.tar.gz https://github.com/sqlmapproject/sqlmap/tarball/master
tar xfvz sqlmap.tar.gz
FOLDER=$(ls | grep sqlmapproject-sqlmap)
mv $FOLDER sqlmap
cd sqlmap
