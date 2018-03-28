#!/bin/bash

PROJECTDIR=$1
PROJECTDIR=`php -r "print realpath('$PROJECTDIR');"`

if [ ! -d "$PROJECTDIR" ]; then
  echo "Error: $PROJECTDIR must be a directory"
  exit 1
fi

SITENAME=`php -r "print trim(preg_replace('{[^0-9a-zA-Z]+}', '-', basename('$PROJECTDIR')), '-');"`

mkdir -p ~/Sites/"$SITENAME"/log
if [ -h ~/Sites/"$SITENAME"/documentroot ]; then
  rm ~/Sites/"$SITENAME"/documentroot
fi
ln -s "$PROJECTDIR" ~/Sites/"$SITENAME"/documentroot

echo "Please enter your password to change the Apache config."
sudo ~/bin/commission-local.sh-sudo.sh "$SITENAME"

#open http://$SITENAME.dev/
open http://$SITENAME.rh/

