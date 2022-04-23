#!/bin/bash

ADB=/Applications/adt-bundle-mac-x86_64-20140321/sdk/platform-tools/adb

$ADB devices -l

if [ -z "`$ADB devices -l | grep usb`" ]; then
  echo "restarting adb"
  $ADB kill-server
  $ADB start-server
  $ADB devices -l
  sleep 4
  $ADB devices -l
fi

