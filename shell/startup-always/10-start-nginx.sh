#!/bin/bash

if [ ! -z "${PROJECT_OPTIONS}" ]; then
  if [[ ! ${PROJECT_OPTIONS} =~ NGINX ]]; then
    echo " --> NGINX not set in PROJECT_OPTIONS. Skipping."
    exit 0
  fi
fi

service nginx restart

exit 0