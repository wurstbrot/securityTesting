#! /bin/sh

export DEBIAN_FRONTEND=noninteractive

add-apt-repository -y ppa:saiarcot895/myppa
apt-get update
apt-get install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" apt-fast
apt-fast upgrade -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"
apt-fast dist-upgrade -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold"

# install software-properties-common
apt-fast install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" software-properties-common

echo "---------------------------"
echo "-- BASE SYSTEM INSTALLED --"
echo "---------------------------"
cat /etc/issue
echo "---------------------------"

exit 0