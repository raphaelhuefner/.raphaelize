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

echo "Start converting DB '$DBNAME' into separate general tablespace '$tablespacename'."
mysql --login-path=$DB_LOGIN_PATH_ADMIN -e"SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA LIKE '$DBNAME' AND ENGINE LIKE 'InnoDB';" --skip-column-names "$DBNAME" | while read tablename; do
  echo "Convert table '$DBNAME.$tablename' into tablespace '$tablespacename'."
  mysql --login-path=$DB_LOGIN_PATH_ADMIN -e"ALTER TABLE $DBNAME.$tablename TABLESPACE $tablespacename;" 
  LAST_RETURN_VALUE=$?
  if [ $LAST_RETURN_VALUE -eq 0 ]; then
    echo "Converted table '$DBNAME.$tablename' into tablespace '$tablespacename'."
    exit 0
  else
    echo "Error: There was a problem converting table '$DBNAME.$tablename' into tablespace '$tablespacename'."
    exit 1
  fi
done
echo "Done converting DB '$DBNAME' into separate general tablespace '$tablespacename'."
