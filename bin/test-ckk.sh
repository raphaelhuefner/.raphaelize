#!/bin/bash

SOLR_HOST="localhost"
SOLR_PORT="8983"
SOLR_CORE=""
SOLR_PATH="/solr"
SOLR_ROOT_DIR="/Applications/solr-4.7.0"
SOLR_INSTANCE_DIR="/ckk_fortmckay"
SOLR_LOG_FILE=~/ckk_solr.log

SELENIUM_HOST="127.0.0.1"
SELENIUM_PORT="4444"
SELENIUM_ROOT_DIR="/Applications"
SELENIUM_VERSION="2.48.2"
SELENIUM_LOG_FILE=~/ckk_selenium.log

function isSolrRunning() {
  if [ -z "`curl -s http://$SOLR_HOST:$SOLR_PORT$SOLR_PATH/admin/cores?action=STATUS | grep -E $SOLR_ROOT_DIR$SOLR_INSTANCE_DIR/solr/collection1/`" ]; then
    # Seems that the CKK Solr server is *NOT* running.
    return 0
  else
    # Seems that the CKK Solr server IS INDEED running.
    return 1
  fi
}

function startSolr() {
  $(
    cd $SOLR_ROOT_DIR$SOLR_INSTANCE_DIR
    java -jar start.jar > $SOLR_LOG_FILE 2>&1 &
  ) &
}

function isSeleniumRunning() {
  if [ -z "`curl -s http://$SELENIUM_HOST:$SELENIUM_PORT/wd/hub/status | grep -E \\"version\\":\\"$SELENIUM_VERSION\\"`" ]; then
    # Seems that the CKK Selenium server is *NOT* running.
    return 0
  else
    # Seems that the CKK Selenium server IS INDEED running.
    return 1
  fi
}

function startSelenium() {
  $(
    cd $SELENIUM_ROOT_DIR
    java -jar selenium-server-standalone-$SELENIUM_VERSION.jar > $SELENIUM_LOG_FILE 2>&1 &
  ) &
}


# Test if Solr is running, and try to start it up if not.
isSolrRunning
if [ 0 == $? ]; then
  echo "Seems that the CKK Solr server is *NOT* running."
  echo "Trying to start the CKK Solr server."
  startSolr
  waitForSolr=TRUE
else
  echo "Seems that the CKK Solr server IS INDEED running."
  waitForSolr=FALSE
fi

# Test if Selenium is running, and try to start it up if not.
isSeleniumRunning
if [ 0 == $? ]; then
  echo "Seems that the CKK Selenium server is *NOT* running."
  echo "Trying to start the CKK Selenium server."
  startSelenium
  waitForSelenium=TRUE
else
  echo "Seems that the CKK Selenium IS INDEED running."
  waitForSelenium=FALSE
fi

# Wait until both Solr AND Selenium are fired up.
while [ TRUE == $waitForSolr -o TRUE == $waitForSelenium ]; do

  sleep 1
  isSolrRunning
  if [ 1 == $? ]; then
    waitForSolr=FALSE
    echo "Seems that the CKK Solr server IS NOW INDEED running."
  fi

  sleep 1
  isSeleniumRunning
  if [ 1 == $? ]; then
    waitForSelenium=FALSE
    echo "Seems that the CKK Selenium server IS NOW INDEED running."
  fi

done


# drush site-install iegcis install_configure_form.update_status_module='array(FALSE,FALSE)' --site-name=CKK --account-mail=raphael+ckk-local-test@affinitybridge.com --account-pass=password --yes

cd ~/projects/affinity/ckk/profiles/iegcis/tests/nightwatch
nightwatch -e raphael-clean

