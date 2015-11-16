#!/bin/bash

if [ -z "$2" ]; then
  echo "Usage: $0 DBUSER DBPASS"
  exit
fi

DBHOST=localhost
DBUSER=$1
DBPASS=$2

mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"SHOW DATABASES;" --skip-column-names | grep -vE "^(information_schema|mysql|performance_schema|sys)$" | while read dbname; do
  tablespacename="ts_$dbname"
  echo "Ensure separate general tablespace '$tablespacename' for DB '$dbname'."
  already_exists="`mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"SELECT TABLESPACE_NAME FROM INFORMATION_SCHEMA.TABLESPACES WHERE TABLESPACE_NAME LIKE '$tablespacename';" --skip-column-names`"
  if [ -z "$already_exists" ]; then
    tablespacefilename="$tablespacename.ibd"
    mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"CREATE TABLESPACE $tablespacename ADD DATAFILE '$tablespacefilename' Engine=InnoDB;" 
    echo "Created tablespace '$tablespacename' in file '$tablespacefilename'."
  fi
  mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA LIKE '$dbname' AND ENGINE LIKE 'InnoDB';" --skip-column-names "$dbname" | while read tablename; do
    echo "Ensure tablespace '$tablespacename' for table '$dbname.$tablename'."
    mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"ALTER TABLE $dbname.$tablename TABLESPACE $tablespacename;" 
  done
  echo "Done ensuring separate general tablespace '$tablespacename' for DB '$dbname'."
done

