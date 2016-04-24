#! /bin/bash

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

if [ -f ${PROJECT_DIR}/srv/sassc/settings.conf ]; then
  source ${PROJECT_DIR}/srv/sassc/settings.conf

  if [ ${autostart} = 1 ]; then
    cd ${PROJECT_DIR}
    nohup /bin/bash ${sasscWatcher} ${watchPath} ${input} ${output} ${libraryPath} ${style} ${sourceMap} > /dev/null 2>&1 &
  fi
fi