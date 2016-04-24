#! /bin/bash

if [ ! -z "${PROJECT_OPTIONS}" ]; then
  if [[ ! ${PROJECT_OPTIONS} =~ MAILCATCHER ]]; then
    echo " --> MAILCATCHER not set in PROJECT_OPTIONS. Skipping."
    exit 0
  fi
fi

/usr/local/bin/mailcatcher --smtp-port 1025 --http-port 8090 --ip 0.0.0.0

exit 0
