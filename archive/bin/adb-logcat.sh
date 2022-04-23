#!/bin/bash

ADB=/Applications/adt-bundle-mac-x86_64-20140321/sdk/platform-tools/adb

$ADB devices -l

if [ -n "`$ADB devices -l | grep usb`" ]; then
  echo "starting adb logcat"
  $ADB logcat
fi

