#!/bin/bash

RAMDISKSIZE_MEGABYTE=2048

RAMDISKSIZE_BLOCKS=$(($RAMDISKSIZE_MEGABYTE * 2048))

RAMDISK_DEVICE=`hdiutil attach -nomount ram://$RAMDISKSIZE_BLOCKS`

diskutil erasevolume hfsx "ramdisk" $RAMDISK_DEVICE 

RAMDISKMOUNT=/Volumes/ramdisk

mkdir -p $RAMDISKMOUNT/mysql/{data,log}

/usr/local/opt/mysql/bin/mysql_install_db --basedir=/usr/local/opt/mysql --datadir=$RAMDISKMOUNT/mysql/data

/usr/local/opt/mysql/bin/mysqld_safe --basedir=/usr/local/opt/mysql --datadir=$RAMDISKMOUNT/mysql/data --bind-address=127.0.0.1 --port=13306 &

sleep 5

/usr/local/opt/mysql/bin/mysqladmin --host=127.0.0.1 --port=13306 --user=root password 'rapha'

# unmount
#diskutil list
#hdiutil detach $RAMDISK_DEVICE

