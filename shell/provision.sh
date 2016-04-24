#!/bin/bash

export PROJECT_DIR="/srv/www/skeleton.local"

## List of possible options:
##
##     NGINX
##     PHP-5.6
##     PHP-5.6-XDEBUG
##     APACHE-FOP
##     MYSQL-5.6
##     PHPMYADMIN
##     REDIS
##     MAILCATCHER
##     VARNISH
##     LIBSASS
##

export PROJECT_OPTIONS="
  NGINX
  PHP-5.6
  PHP-5.6-XDEBUG
  MYSQL-5.6
  MAILCATCHER
"

STARTUP_ONCE=${PROJECT_DIR}/shell/startup-once/*.sh

echo "****************************"
echo "**** SHELL PROVISIONING ****"
echo "****************************"

for f in $STARTUP_ONCE; do
  echo ">>>> Executing shell provisioning script $f <<<<"
  bash $f
done

mkdir -p /var/lib/vagrant
echo "${PROJECT_OPTIONS}" > /var/lib/vagrant/project_options
echo "${PROJECT_DIR}"     > /var/lib/vagrant/project_dir

exit 0