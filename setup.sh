#!/usr/bin/env bash

# Make Bash's error handling strict(er).
set -o nounset -o pipefail -o errexit

while read cfg_item; do
  source=~/.raphaelize/$cfg_item
  target=~/$cfg_item
  if ! [ -a "$target" ]; then
    ln -s $source $target
  else
    if ! [ -h "$target" ]; then
      echo "Can not .raphaelize $target since it already exists"
    fi
  fi
done << EOF
.gitconfig
.gitconfig-personal
.gitglobalattributes
.gitglobalignore
.bash_aliases
.vim
.vimrc
bin
EOF

if ! [ -a "~/.gitconfig-professional" ]; then
  touch ~/.gitconfig-professional
fi
