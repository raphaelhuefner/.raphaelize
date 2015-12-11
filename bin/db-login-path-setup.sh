#!/bin/bash

echo "Setting up the mysql admin account with username 'root':"
mysql_config_editor set --login-path=admin --user=root --host=127.0.0.1 --port=3306 --password

echo "Setting up the mysql dev account with username 'dev':"
mysql_config_editor set --login-path=dev --user=dev --host=127.0.0.1 --port=3306 --password
