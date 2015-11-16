#!/bin/bash

DBNAME=gcsc_hotfix_masterbranch
BACKUPDIR_LOCAL=~/projects/affinity/resources/gcsc
BACKUPDIR_SERVER=~/backups/db
SERVER=owprod


DBCONNECT="mysql -hlocalhost -P3306 -udev -pdev --default-character-set=utf8 --silent $DBNAME"

remote_filename=`ssh -q $SERVER "~/bin/db-backup-gcsc.sh"`
scp $SERVER:$remote_filename $BACKUPDIR_LOCAL
BACKUPFILENAME=`basename $remote_filename`

# drop tables
tables=`$DBCONNECT -e"SHOW TABLES;"`
drop_cmd="DROP TABLE "
for table in $tables;
do
  drop_cmd="$drop_cmd \`$table\`,"
done
drop_cmd=${drop_cmd%","}";"
$DBCONNECT -e"SET foreign_key_checks = 0; $drop_cmd"

bunzip2 < $BACKUPDIR_LOCAL/$BACKUPFILENAME | $DBCONNECT

