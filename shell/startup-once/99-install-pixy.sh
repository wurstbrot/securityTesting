#!/bin/bash

cd /home/vagrant
sudo apt-get install -y ant git openjdk-8-jdk
git clone https://github.com/oliverklee/pixy.git
cd pixy
ant build
