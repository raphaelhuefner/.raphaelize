#!/bin/bash

if [ -z "$3" ]; then
  echo "Usage: $0 DBUSER DBPASS DBNAME"
  exit
fi

DBHOST=localhost
DBUSER=$1
DBPASS=$2
DBNAME=$3

tablespacename="ts_$DBNAME"

already_exists="`mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"SELECT TABLESPACE_NAME FROM INFORMATION_SCHEMA.TABLESPACES WHERE TABLESPACE_NAME LIKE '$tablespacename';" --skip-column-names`"
if [ -z "$already_exists" ]; then
  tablespacefilename="$tablespacename.ibd"
  mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"CREATE TABLESPACE $tablespacename ADD DATAFILE '$tablespacefilename' Engine=InnoDB;" 
  echo "Created tablespace '$tablespacename' in file '$tablespacefilename'."
fi

# Why use LC_ALL? ---> @see http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
LC_ALL=C sed "s/ENGINE=InnoDB/TABLESPACE $tablespacename ENGINE=InnoDB/g" < /dev/stdin | mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" "$DBNAME"
