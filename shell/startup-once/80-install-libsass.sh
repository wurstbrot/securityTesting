#! /bin/sh

if [ -z "${PROJECT_DIR}" ]; then
  echo "Variable PROJECT_DIR is not set. Aborting."
  exit 1
fi

if [ ! -z "${PROJECT_OPTIONS}" ]; then
  if [[ ! ${PROJECT_OPTIONS} =~ LIBSASS ]]; then
    echo " --> LIBSASS not set in PROJECT_OPTIONS. Skipping."
    exit 0
  fi
fi

export DEBIAN_FRONTEND=noninteractive

if [ -d /usr/lib/sassc ]; then
  rm -R /usr/lib/sassc
fi

if [ -d /usr/lib/libsass ]; then
  rm /usr/bin/sassc
  rm -R /usr/lib/libsass
fi

if [ -f ${PROJECT_DIR}/scripts/sassc-watcher.sh ]; then
  rm ${PROJECT_DIR}/scripts/sassc-watcher.sh
fi

# install build tools
apt-fast install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" build-essential git

# fetch newest sassc and libsass sources
git clone https://github.com/hcatlin/sassc.git /usr/lib/sassc
git clone https://github.com/hcatlin/libsass.git /usr/lib/libsass

# build libsass and sassc
cp /usr/lib/sassc/Makefile /usr/lib/sassc/MakefileBak
echo "export SASS_LIBSASS_PATH=/usr/lib/libsass" > /usr/lib/sassc/Makefile
cat /usr/lib/sassc/MakefileBak >> /usr/lib/sassc/Makefile
rm /usr/lib/sassc/MakefileBak
cd /usr/lib/sassc; make
ln -s /usr/lib/sassc/bin/sassc /usr/bin/sassc

if [ -f /usr/bin/sassc ]; then
  echo "libSASS and SASSC has been installed"
else
  echo "libSASS and SASSC has not been installed, see logs"
fi

exit 0