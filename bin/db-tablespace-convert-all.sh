#!/bin/bash

DB_LOGIN_PATH_ADMIN=admin

db-login-path-exists.sh $DB_LOGIN_PATH_ADMIN
LAST_RETURN_VALUE=$?
if [ $LAST_RETURN_VALUE -ne 0 ]; then
  echo "Error: There was a problem detecting the mysql login path named '$DB_LOGIN_PATH_ADMIN'."
  exit 1
fi

mysql --login-path=$DB_LOGIN_PATH_ADMIN -e"SHOW DATABASES;" --skip-column-names | grep -vE "^(information_schema|mysql|performance_schema|sys)$" | while read dbname; do
  db-tablespace-convert.sh "$dbname"
  LAST_RETURN_VALUE=$?
  if [ $LAST_RETURN_VALUE -eq 0 ]; then
    echo "Sucessfully converted DB '$dbname' into using a separate general tablespace."
    exit 0
  else
    echo "Error: There was a problem converting DB '$dbname' into using a separate general tablespace."
    exit 1
  fi
done
