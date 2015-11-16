#!/bin/bash

DBUSER=$1
DBPASS=$2

TODAY=`date -u +%Y-%m-%dT%H-%M-%SZ`
#DIRNAME=~/backup/db/$TODAY
DIRNAME=/Volumes/data/raphael/backup/db/$TODAY

mkdir -p $DIRNAME
mysql -hlocalhost -u$DBUSER -p$DBPASS -e"SHOW DATABASES;" --skip-column-names | while read dbname; do
    echo "start dumping $dbname"
    mysqldump -hlocalhost -u$DBUSER -p$DBPASS --default-character-set=utf8 --no-create-db --routines --triggers $dbname | bzip2 > $DIRNAME/$dbname-$TODAY.sql.bz2
    echo "done dumping $dbname"
done

