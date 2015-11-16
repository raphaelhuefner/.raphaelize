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

datadir="`mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"SELECT @@GLOBAL.datadir;" --silent --skip-column-names`"
datadir=${datadir%/}
tablespacefullfilename="$datadir/$tablespacename.ibd"

if [ -f "$tablespacefullfilename" ]; then
  echo "Found tablespace file '$tablespacefullfilename'."
else
  echo "Error: Could not find tablespace file '$tablespacefullfilename'. Aborting."
  exit 1
fi

# Why use LC_ALL? ---> @see http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
LC_ALL=C sed "s/ENGINE=InnoDB/TABLESPACE $tablespacename ENGINE=InnoDB/g" < /dev/stdin | mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" "$DBNAME"
