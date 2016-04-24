#!/bin/bash

if [ -f /var/lib/vagrant/project_dir ]; then
  export PROJECT_DIR=$( < /var/lib/vagrant/project_dir )
else
  echo "ERROR starting $0 - Could not find /var/lib/vagrant/project_dir"
  exit 1
fi

if [ -f /var/lib/vagrant/project_options ]; then
  export PROJECT_OPTIONS=$( < /var/lib/vagrant/project_options )
else
  echo "ERROR starting $0 - Could not find /var/lib/vagrant/project_options"
  exit 1
fi

STARTUP_ALWAYS=${PROJECT_DIR}/shell/startup-always/*.sh

echo "************************"
echo "**** SHELL START-UP ****"
echo "************************"

for f in $STARTUP_ALWAYS; do
  echo ">>>> Executing shell start-up script $f ..."
  bash $f
done

exit 0