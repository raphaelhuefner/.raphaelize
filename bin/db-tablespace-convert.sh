#!/bin/bash

DB_LOGIN_PATH_ADMIN=admin

db-login-path-exists.sh $DB_LOGIN_PATH_ADMIN
LAST_RETURN_VALUE=$?
if [ $LAST_RETURN_VALUE -ne 0 ]; then
  echo "Error: There was a problem detecting the mysql login path named '$DB_LOGIN_PATH_ADMIN'."
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: $0 [--force-innodb] DBNAME"
  echo "--force-innodb : force all MyISAM tables to be converted into InnoDB"
  exit 2
fi

force_innodb=""

if [ '--force-innodb' == "$1" -a -n "$2" ]; then
  DBNAME=$2
  force_innodb=TRUE
else
  DBNAME=$1
  if [ '--force-innodb' == "$2" ]; then
    force_innodb=TRUE
  fi
fi

if [ -n "$force_innodb" ]; then
  echo "Forcing MyISAM tables to be converted into InnoDB."
  select_tables_engine_clause="ENGINE LIKE 'InnoDB' OR ENGINE LIKE 'MyISAM'"
  alter_table_engine_clause='ENGINE=InnoDB'
else
  select_tables_engine_clause="ENGINE LIKE 'InnoDB'"
  alter_table_engine_clause=''
fi

db-tablespace-create-if-not-exists.sh $DBNAME
LAST_RETURN_VALUE=$?
if [ $LAST_RETURN_VALUE -ne 0 ]; then
  echo "Error: There was a problem ensuring the existance of a separate tablespace for DB '$DBNAME'."
  exit 1
fi

tablespacename="`db-tablespace-get-name.sh $DBNAME`"

echo "Start converting DB '$DBNAME' into separate general tablespace '$tablespacename'."
mysql --login-path=$DB_LOGIN_PATH_ADMIN -e"SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA LIKE '$DBNAME' AND ($select_tables_engine_clause);" --skip-column-names "$DBNAME" | while read tablename; do
  echo -n "TABLE '$DBNAME.$tablename': "
  backtick='`'
  table_definition_with_tablespace="`mysql --login-path=$DB_LOGIN_PATH_ADMIN -e"SHOW CREATE TABLE $DBNAME.$tablename;" --silent --skip-column-names | grep -E "TABLESPACE $backtick$tablespacename$backtick"`"
  if [ -n "$table_definition_with_tablespace" ]; then
    echo "Already in tablespace '$tablespacename'."
  else
    echo -n "Converting into tablespace '$tablespacename'. "
    mysql --login-path=$DB_LOGIN_PATH_ADMIN -e"ALTER TABLE $DBNAME.$tablename $alter_table_engine_clause TABLESPACE $tablespacename;"
    LAST_RETURN_VALUE=$?
    if [ $LAST_RETURN_VALUE -eq 0 ]; then
      echo "Done."
    else
      echo "Error: There was a problem converting table '$DBNAME.$tablename' into tablespace '$tablespacename'."
      exit 1
    fi
  fi
done
echo "Done converting DB '$DBNAME' into separate general tablespace '$tablespacename'."
