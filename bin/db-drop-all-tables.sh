#!/bin/bash

if [[ -z "`drush sql-connect | grep -- '--database.*--password'`" ]]; then
  echo "Error: Drush can not find DB credentials."
  exit
fi

read -e -p"Really drop all tables? (yes/no) " confirmation

if [[ "yes" != $confirmation ]]; then
  echo "Sorry, I need a full 'yes' to go ahead."
  exit
fi

DBCONNECT="`drush sql-connect` --default-character-set=utf8 --silent"

# Drop views first because they would get listed by "SHOW TABLES;" as well.
views=`$DBCONNECT -e"SHOW FULL TABLES WHERE Table_type = 'VIEW';"`
drop_cmd="DROP VIEW IF EXISTS "
for view in $views;
do
  # Skip values from the "Table_type" column.
  if [[ "VIEW" == $view ]]; then
    continue
  fi
  drop_cmd="$drop_cmd \`$view\`,"
done
drop_cmd=${drop_cmd%","}";"
$DBCONNECT -e"SET foreign_key_checks = 0; $drop_cmd"

# Drop tables.
tables=`$DBCONNECT -e"SHOW TABLES;"`
drop_cmd="DROP TABLE IF EXISTS "
for table in $tables;
do
  drop_cmd="$drop_cmd \`$table\`,"
done
drop_cmd=${drop_cmd%","}";"
$DBCONNECT -e"SET foreign_key_checks = 0; $drop_cmd"
