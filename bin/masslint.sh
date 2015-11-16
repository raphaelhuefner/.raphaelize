#!/bin/bash

# find . -not -path "*.svn*" -not -path "*logs*" "(" -path "*.php" -or -path "*.phtml" ")" -execdir php -l "{}" ";" | less
find . -not -path "*.svn*" -not -path "*logs*" "(" -path "*.php" -or -path "*.phtml" ")" -exec php -l "{}" ";" | grep --invert-match "^No syntax errors detected in " | less

