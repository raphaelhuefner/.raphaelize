#!/usr/bin/env bash

# Make Bash's error handling strict(er).
set -o nounset -o pipefail -o errexit

# Source https://www.debugpoint.com/clean-up-snap/
# Source https://superuser.com/questions/1310825/how-to-remove-old-version-of-installed-snaps/1330590#1330590

#Removes old revisions of snaps
#CLOSE ALL SNAPS BEFORE RUNNING THIS
set -eu
LANG=en_US.UTF-8 snap list --all | awk '/disabled/{print $1, $3}' |
  while read snapname revision; do
    sudo snap remove "$snapname" --revision="$revision"
  done
