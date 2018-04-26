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

# use ".rh" top level domain for local dev sites
HOSTNAME=$SITENAME.rh

# create Apache vhost config file in /usr/local/etc/httpd/vhosts/
sed 's/###SITENAME###/'$SITENAME'/g' < /usr/local/etc/httpd/vhosts/_conf.template > /usr/local/etc/httpd/vhosts/$SITENAME.conf

# some debug output
/usr/local/bin/apachectl -S

# notify Apache of new config
echo "Please enter your password to change the Apache config."
sudo brew services restart httpd

# some user feedback
echo "Local vhost $HOSTNAME commissioned. Test at: http://$HOSTNAME/"

open http://$HOSTNAME/

