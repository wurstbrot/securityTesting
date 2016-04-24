#! /bin/sh

if [ -z "${PROJECT_DIR}" ]; then
  echo "Variable PROJECT_DIR is not set. Aborting."
  exit 1
fi

if [ ! -z "${PROJECT_OPTIONS}" ]; then
  if [[ ! ${PROJECT_OPTIONS} =~ VARNISH ]]; then
    echo " --> VARNISH not set in PROJECT_OPTIONS. Skipping."
    exit 0
  else
    echo ">>>>> VARNISH IN PROJECT_OPTIONS"
  fi
else
  echo ">>>>> LEERE PROJECT_OPTIONS"
fi

export DEBIAN_FRONTEND=noninteractive

apt-fast install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" varnish

if [ -f "${PROJECT_DIR}/srv/varnish/default.vcl" ]; then
  service varnish stop
  if [ -f "${PROJECT_DIR}/srv/default/varnish" ]; then
    cat "${PROJECT_DIR}/srv/default/varnish" > /etc/default/varnish
  fi
  if [ -f /etc/varnish/default.vcl ]; then
    rm /etc/varnish/default.vcl
  fi
  ln -s "${PROJECT_DIR}/srv/varnish/default.vcl" /etc/varnish/default.vcl
  service varnish start
fi

exit 0