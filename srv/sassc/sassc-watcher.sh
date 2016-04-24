#!/usr/bin/env bash
# script:  sassc-watcher.sh
# author: Patrick Patzelt <ppatzelt@eenit.de>
# author of basefile:  Mike Smullin <mike@smullindesign.com> (https://gist.github.com/mikesmullin/6401258)
# description:
#   watches the given path for changes and triggers the sassc-compiler with given options
# usage:
#   cd [PROJECT_DIR]
#   srv/sassc/sassc-watcher.sh <path-to-watch (sass-folder)> <input-sass-file> <output-css-files> <including libary-path, default path> <style-type, default compressed> <sourcemap, default false>
# example (overriding settings.conf):
#   cd [PROJECT_DIR]
#   srv/sassc/sassc-watcher.sh sass sass/portal/css/default.sass htdocs/themes/portal/css/default.css sass compressed true
# example (using settings.conf):
#   cd [PROJECT_DIR]
#   srv/sassc/sassc-watcher.sh

# detect absolute path name of this script
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BASE_PATH=$(readlink -f ${SCRIPT_DIR}/../..)
cd ${BASE_PATH}

path=$1

if [[ ${path} == '' ]]; then
  source ${BASE_PATH}/srv/sassc/settings.conf
  echo ${BASE_PATH}/srv/sassc/settings.conf

  path=${watchPath}
else
  shift
  input=$1
  shift
  output=$1
  shift
  libraryPath=$1
  shift
  style=$1
  shift
  sourceMap=$1
fi

sha=0

update_sha() {
  sha=`ls -lR --time-style=full-iso $path | sha1sum`
}

update_sha
previous_sha=${sha}

build() {
  echo -en " building...\n\n"

  if [[ ${libraryPath} == '' ]] ; then
    libraryPath=${path}
  fi

  if [[ ${style} == '' ]] ; then
    style="compressed"
  fi

  if [[ ${sourceMap} != '' && ${sourceMap} != 0 && ${sourceMap} != '0' ]] ; then
    sourceMap="--sourcemap"
  else
    sourceMap="--omit-map-comment"
  fi

  /usr/bin/sassc ${input} ${output} --style ${style} --load-path ${libraryPath} ${sourceMap}
  echo -en "\n--> resumed watching."
}

compare() {
  update_sha

  if [[ ${sha} != ${previous_sha} ]] ; then
    echo -n "change detected,"
    build
    previous_sha=$sha
  else
    echo -n .
  fi
}

trap build SIGQUIT
trap exit SIGINT

echo -e  "--> Press Ctrl+C to exit, Ctrl+# to force build."
echo -en "--> watching \"$path\"."

while true; do
  compare
  sleep 1
done