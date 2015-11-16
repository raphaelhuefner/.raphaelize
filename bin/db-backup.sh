#!/bin/bash

DBNAME="$1"

TODAY=`date -u +%Y-%m-%dT%H-%M-%SZ`
mysqldump -hlocalhost -P3306 -udev -p"dev" --default-character-set=utf8 --no-create-db --routines --triggers "$DBNAME" | bzip2 > ~/backup/db/$DBNAME-$TODAY.sql.bz2


