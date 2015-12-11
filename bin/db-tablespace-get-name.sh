#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: $0 DBNAME"
  exit
fi

DBNAME=$1

TABLESPACENAME="ts_$DBNAME"

echo $TABLESPACENAME
