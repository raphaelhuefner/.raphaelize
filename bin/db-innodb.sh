#!/bin/bash

if [ -z "$3" ]; then
  echo "Usage: $0 DBUSER DBPASS DBNAME"
  exit
fi

DBHOST=localhost
DBUSER=$1
DBPASS=$2
DBNAME=$3

dbname=$DBNAME

tablespacename="ts_$dbname"
echo "Ensure separate general tablespace '$tablespacename' for DB '$dbname'."

datadir="`mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"SELECT @@GLOBAL.datadir;" --silent --skip-column-names`"
datadir=${datadir%/}
tablespacefullfilename="$datadir/$tablespacename.ibd"

if [ -f "$tablespacefullfilename" ]; then
  echo "Found tablespace file '$tablespacefullfilename'."
else
  echo "Trying to create tablespace '$tablespacename'."
  tablespacefilename="$tablespacename.ibd"
  mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"CREATE TABLESPACE $tablespacename ADD DATAFILE '$tablespacefilename' Engine=InnoDB;" 
  echo "Created tablespace '$tablespacename' in file '$tablespacefilename'."
fi

mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA LIKE '$dbname' AND ENGINE NOT LIKE 'InnoDB';" --skip-column-names "$dbname" | while read tablename; do
  echo "Ensure InnoDB engine AND tablespace '$tablespacename' for table '$dbname.$tablename'."
  mysql -h"$DBHOST" -u"$DBUSER" -p"$DBPASS" -e"ALTER TABLE $dbname.$tablename ENGINE=InnoDB TABLESPACE $tablespacename;" 
done
