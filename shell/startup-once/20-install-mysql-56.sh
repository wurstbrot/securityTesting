#! /bin/sh

MYSQL_ROOT_PASSWORD="root"
MYSQL_DB="skeleton"
MYSQL_USR="skeleton"
MYSQL_PASS="skeleton"

if [ -z "${PROJECT_DIR}" ]; then
  echo "Variable PROJECT_DIR is not set. Aborting."
  exit 1
fi

if [ ! -z "${PROJECT_OPTIONS}" ]; then
  if [[ ! ${PROJECT_OPTIONS} =~ MYSQL-5.6 ]]; then
    echo " --> MYSQL-5.6 not set in PROJECT_OPTIONS. Skipping."
    exit 0
  fi
fi

export DEBIAN_FRONTEND=noninteractive

apt-fast install -q -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" mysql-server-5.6 mysql-client-5.6

update-rc.d mysql defaults

mysqladmin -u root password "${MYSQL_ROOT_PASSWORD}" > /dev/null 2>&1

mysql -u root -p${MYSQL_ROOT_PASSWORD} <<EOF
  CREATE DATABASE ${MYSQL_DB} CHARACTER SET utf8 COLLATE utf8_general_ci;
  GRANT USAGE ON *.* TO '${MYSQL_USR}'@'%' IDENTIFIED BY '${MYSQL_PASS}';
  GRANT ALL PRIVILEGES ON ${MYSQL_DB}.* TO '${MYSQL_USR}'@'%';
  FLUSH PRIVILEGES;
EOF

if [ -d ${PROJECT_DIR}/sql ]; then
  DUMP=`ls -1Xr ${PROJECT_DIR}/sql | head -1`
  echo -n "Importing database file ${DUMP} ... "
  mysql -u root -p${MYSQL_ROOT_PASSWORD} ${MYSQL_DB} < ${PROJECT_DIR}/sql/$DUMP > /dev/null 2>&1
  if [ $? -eq 0 ]; then
    echo "Done"
  else
    echo "Failed"
  fi
fi

exit 0