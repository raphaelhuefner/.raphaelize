#!/bin/bash

DB_LOGIN_PATH_ADMIN=admin

db-login-path-exists.sh $DB_LOGIN_PATH_ADMIN
LAST_RETURN_VALUE=$?
if [ $LAST_RETURN_VALUE -ne 0 ]; then
  echo "Error: There was a problem detecting the mysql login path named '$DB_LOGIN_PATH_ADMIN'."
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $0 DBNAME"
  exit 1
fi

DBNAME=$1

tablespacename="ts_$DBNAME"

echo "Ensure existance of a separate general tablespace '$tablespacename' for DB '$DBNAME'."

datadir="`mysql --login-path=$DB_LOGIN_PATH_ADMIN -e"SELECT @@GLOBAL.datadir;" --silent --skip-column-names`"
datadir=${datadir%/}
tablespacefullfilename="$datadir/$tablespacename.ibd"

if [ -f "$tablespacefullfilename" ]; then
  echo "Found tablespace file '$tablespacefullfilename'."
  exit 0
else
  echo "Trying to create tablespace '$tablespacename'."
  tablespacefilename="$tablespacename.ibd"
  mysql --login-path=$DB_LOGIN_PATH_ADMIN -e"CREATE TABLESPACE $tablespacename ADD DATAFILE '$tablespacefilename' Engine=InnoDB;" 
  LAST_RETURN_VALUE=$?
  if [ $LAST_RETURN_VALUE -eq 0 ]; then
    echo "Created tablespace '$tablespacename' in file '$tablespacefilename'."
    exit 0
  else
    echo "Error: There was a problem creating the tablespace '$tablespacename'."
    exit 1
  fi
fi
