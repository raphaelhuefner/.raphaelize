#!/bin/bash

DRUSH_PHP=/usr/local/opt/php55/bin/php
PHP_INI=/usr/local/etc/php/5.5/php.ini

export DRUSH_PHP
export PHP_INI

#/Users/raphael/drush/drush --root=/Users/raphael/projects/affinity/vancouverfoundation/public_html --uri=http://vancouverfoundation.dev/ core-cron

#/Users/raphael/drush/drush --root=/Users/raphael/projects/affinity/vancouverfoundation/public_html --uri=http://vancouverfoundation.dev/ eval "phpinfo();"
