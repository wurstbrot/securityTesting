#! /bin/sh

if [ ! -z "${PROJECT_OPTIONS}" ]; then
  if [[ ! ${PROJECT_OPTIONS} =~ MAILCATCHER ]]; then
    echo " --> MAILCATCHER not set in PROJECT_OPTIONS. Skipping."
    exit 0
  fi
fi

export DEBIAN_FRONTEND=noninteractive

# install ruby2.2
apt-add-repository -y ppa:brightbox/ruby-ng
apt-fast update
apt-fast install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" ruby2.2 ruby2.2-dev postfix mailutils build-essential software-properties-common libsqlite3-dev

# modify postfix
sed -i 's/^relayhost =\s*$/relayhost = localhost:1025/gm' /etc/postfix/main.cf
service postfix restart

# install MailCatcher
ruby -S gem install mailcatcher -V -N

exit 0