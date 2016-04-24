#! /bin/sh

if [ -z "${PROJECT_DIR}" ]; then
  echo "Variable PROJECT_DIR is not set. Aborting."
  exit 1
fi

if [ ! -z "${PROJECT_OPTIONS}" ]; then
  if [[ ! ${PROJECT_OPTIONS} =~ NGINX ]]; then
    echo " --> NGINX not set in PROJECT_OPTIONS. Skipping."
    exit 0
  fi
fi

export DEBIAN_FRONTEND=noninteractive

# install nginx
add-apt-repository -y ppa:nginx/stable
apt-fast update
apt-fast install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" nginx

if [ ! -f /etc/ssl/certs/dhparam.pem ] && [ -d ${PROJECT_DIR}/srv/nginx/ssl ]; then
  openssl dhparam -out /etc/ssl/certs/dhparam.pem 2048
fi

service nginx stop

if [ -f /etc/nginx/sites-enabled/default ]; then
  rm /etc/nginx/sites-enabled/default
fi

if [ -f ${PROJECT_DIR}/srv/nginx/nginx.conf ]; then
  cat ${PROJECT_DIR}/srv/nginx/nginx.conf > /etc/nginx/nginx.conf

  if [ -d ${PROJECT_DIR}/srv/nginx/conf.d ]; then
    mkdir -p /etc/nginx/conf.d
    cd /etc/nginx/conf.d
    ln -s ${PROJECT_DIR}/srv/nginx/conf.d/* .
  fi

  if [ -d ${PROJECT_DIR}/srv/nginx/includes ]; then
    mkdir -p /etc/nginx/includes
    cd /etc/nginx/includes
    ln -s ${PROJECT_DIR}/srv/nginx/includes/* .
  fi

  if [ -d ${PROJECT_DIR}/srv/nginx/ssl ]; then
    mkdir -p /etc/nginx/ssl
    cd /etc/nginx/ssl
    ln -s ${PROJECT_DIR}/srv/nginx/ssl/* .
  fi

  if [ -d /etc/nginx/sites-enabled ]; then
    cd /etc/nginx/sites-enabled
    ln -s ${PROJECT_DIR}/srv/nginx/sites-enabled/*.conf .
  fi

elif [ "$( ls -A ${PROJECT_DIR}/srv/nginx/*.local.conf )" ]; then

  cd /etc/nginx/sites-enabled
  ln -s ${PROJECT_DIR}/srv/nginx/*.local.conf .

fi

service nginx start

update-rc.d nginx defaults

exit 0