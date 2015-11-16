#!/bin/bash

DRUPALROOT=`drush status --pipe | grep "drupal_root"`
DRUPALROOT=${DRUPALROOT#drupal_root=}
PROJECTNAME=`basename $DRUPALROOT`

drush sql-query "UPDATE users SET mail = CONCAT('raphael+$PROJECTNAME-local-', uid, '@affinitybridge.com') WHERE uid > 0;"

