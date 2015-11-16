#!/bin/bash

# first argument is the machine name of the local website about to be commissioned
SITENAME=$1

# use ".dev" top level domain for local dev sites
HOSTNAME=$SITENAME.dev

# create Apache config file in /etc/apache2/sites-available/
sed 's/###SITENAME###/'$SITENAME'/g' < /etc/apache2/sites-available/_template.conf > /etc/apache2/sites-available/$SITENAME.conf

# remove symlink in /etc/apache2/sites-enabled/
if [ -h /etc/apache2/sites-enabled/$SITENAME.conf ]; then
  rm /etc/apache2/sites-enabled/$SITENAME.conf
fi

# create new symlink in /etc/apache2/sites-enabled/
ln -s ../sites-available/$SITENAME.conf /etc/apache2/sites-enabled/$SITENAME.conf

# append new local hostname in /etc/hosts
if [ -z "`grep "$HOSTNAME" /etc/hosts`" ]; then
  sed -i -e '/127\.0\.0\.1/s/$/ '"$HOSTNAME"'/' /etc/hosts
fi

# some debug output
/usr/sbin/apachectl -S

# notify Apache of new config
/usr/sbin/apachectl restart

# some user feedback
echo "Local vhost $HOSTNAME commissioned. Test at: http://$HOSTNAME/"

