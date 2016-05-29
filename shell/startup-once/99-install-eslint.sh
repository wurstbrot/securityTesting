#!/bin/sh

cd /home/vagrant
sudo apt-get install -y npm node.js nodejs-legacy
npm install -g eslint
npm install -g eslint-plugin-scanjs-rules
npm install -g eslint-plugin-no-unsafe-innerhtml
cp /vagrant/srv/eslint/.eslintrc /home/vagrant
