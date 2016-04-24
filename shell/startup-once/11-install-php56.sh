#! /bin/sh

if [ ! -z "${PROJECT_OPTIONS}" ]; then
  if [[ ! ${PROJECT_OPTIONS} =~ PHP-5.6 ]]; then
    echo " --> PHP-5.6 not set in PROJECT_OPTIONS. Skipping."
    exit 0
  fi
fi

export DEBIAN_FRONTEND=noninteractive

# install php5.6
add-apt-repository -y ppa:ondrej/php5-5.6
apt-fast update
apt-fast install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" php5-fpm php5-cli php5-gd php5-geoip php5-mcrypt php5-imagick php5-mysql php5-curl php5-redis php5-intl php5-ldap

sed -i 's/listen = 127.0.0.1:9000/listen = \/var\/run\/php5-fpm.sock/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/pm = dynamic/pm = static/g' /etc/php5/fpm/pool.d/www.conf
sed -i 's/pm.max_children =.*/pm.max_children = 12/g' /etc/php5/fpm/pool.d/www.conf

sed -i 's/;emergency_restart_threshold = 0/emergency_restart_threshold = 10/g' /etc/php5/fpm/php-fpm.conf
sed -i 's/;emergency_restart_interval = 0/emergency_restart_interval = 1m/g' /etc/php5/fpm/php-fpm.conf
sed -i 's/;process_control_timeout = 0/process_control_timeout = 10s/g' /etc/php5/fpm/php-fpm.conf

sed -i 's/memory_limit.*$/memory_limit = 256M/g' /etc/php5/fpm/php.ini
sed -i 's/query_cache_size.*$/query_cache_size = 64M/g' /etc/php5/fpm/php.ini
sed -i 's/session.name = PHPSESSID/session.name = SESSION/g' /etc/php5/fpm/php.ini
sed -i 's/session.name = PHPSESSID/session.name = SESSION/g' /etc/php5/fpm/php.ini
sed -i 's/post_max_size = 8M/post_max_size = 32M/g' /etc/php5/fpm/php.ini
sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 32M/g' /etc/php5/fpm/php.ini
sed -i 's/session.hash_function = 0/session.hash_function = 7/g' /etc/php5/fpm/php.ini
sed -i 's/session.hash_bits_per_character = 5/session.hash_bits_per_character = 6/g' /etc/php5/fpm/php.ini

service php5-fpm restart
update-rc.d php5-fpm defaults

exit 0