#!/bin/bash

#find . -not -path "*.svn*" -not -path "*logs*" "(" -path "*.php" -or -path "*.phtml" -or -path "*.sql" ")" -exec php ~/bin/is_utf8.php "{}" ";" | grep --invert-match "^valid utf8:" | less
find . -not -path "*.svn*" -not -path "*logs*" "(" -path "*.php" -or -path "*.phtml" ")" -exec php ~/bin/is_utf8.php "{}" ";" | grep --invert-match "^valid utf8: " | less

