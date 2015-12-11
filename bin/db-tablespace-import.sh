#!/bin/bash

DB_LOGIN_PATH_NORMAL=dev

db-login-path-exists.sh $DB_LOGIN_PATH_NORMAL
LAST_RETURN_VALUE=$?
if [ $LAST_RETURN_VALUE -ne 0 ]; then
  echo "Error: There was a problem detecting the mysql login path named '$DB_LOGIN_PATH_NORMAL'."
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $0 DBNAME"
  exit
fi

DBNAME=$1

db-tablespace-create-if-not-exists.sh $DBNAME
LAST_RETURN_VALUE=$?
if [ $LAST_RETURN_VALUE -ne 0 ]; then
  echo "Error: There was a problem ensuring the existance of a separate tablespace for DB '$DBNAME'."
  exit 1
fi

tablespacename="`db-tablespace-get-name.sh $DBNAME`"

# Why use LC_ALL? ---> @see http://stackoverflow.com/questions/19242275/re-error-illegal-byte-sequence-on-mac-os-x
LC_ALL=C sed "s/ENGINE=InnoDB/TABLESPACE $tablespacename ENGINE=InnoDB/g" < /dev/stdin | mysql --login-path=$DB_LOGIN_PATH_NORMAL "$DBNAME"
