#!/bin/bash

apt-get install -y ruby
cd /home/vagrant
wget https://github.com/Arachni/arachni/releases/download/v1.4/arachni-1.4-0.5.10-linux-x86_64.tar.gz
tar xfvz arachni-1.4-0.5.10-linux-x86_64.tar.gz
chmod -R 777 /home/vagrant/arachni-1.4-0.5.10
