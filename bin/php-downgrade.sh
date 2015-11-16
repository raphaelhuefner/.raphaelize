#!/bin/bash

PERSISTENCE_FILE=list-of-installed-php-packages.txt

if [ ! -e $PERSISTENCE_FILE ]; then
	dpkg -l | grep php | awk '{ORS=" ";print $2}' > $PERSISTENCE_FILE;
fi

sed s/lucid/karmic/g /etc/apt/sources.list > /etc/apt/sources.list.d/karmic.list

for name in `cat $PERSISTENCE_FILE`;
do
	if [ -n "`apt-cache showpkg $name | grep karmic-updates`" ]; then
		archive=karmic-updates
	else
		archive=karmic
	fi

	echo Package: $name
	echo Pin: release a=$archive
#	echo Pin: release a=karmic-updates
#	echo Pin: version 5.2.*
	echo Pin-Priority: 991
	echo 
done > /etc/apt/preferences.d/php

apt-get remove -q -y `cat $PERSISTENCE_FILE`;
apt-get install -q -y -m `cat $PERSISTENCE_FILE`;

/etc/init.d/apache2 restart

