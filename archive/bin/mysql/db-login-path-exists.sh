#!/bin/bash

LOGIN_PATH_NAME=$1

if [ -z "`mysql_config_editor print --login-path=$LOGIN_PATH_NAME`" ]; then
  echo "Could not find mysql login path '$LOGIN_PATH_NAME'."
  echo "Try running this to set up such a mysql login path:"
  echo "  mysql_config_editor set --login-path=$LOGIN_PATH_NAME --user=USERNAME --host=HOSTNAME --port=PORTNUMBER --password"
  exit 1
else
  echo "Found mysql login path '$LOGIN_PATH_NAME'."
  exit 0
fi
