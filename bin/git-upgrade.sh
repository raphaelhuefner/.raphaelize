#!/bin/bash

current_changes="`git status --short --porcelain`"
current_branch="`git symbolic-ref --short --quiet HEAD`"

if [ -n "$current_changes" ]; then
  git status
  RED_BACKGROUND='\033[30;41m'
  NO_COLOR='\033[0m'
  echo -e "${RED_BACKGROUND}ERROR:"            "Working tree or index have uncommitted changes. Will not upgrade any git branches from remote.${NO_COLOR}"
  echo -e "${RED_BACKGROUND}ERROR:${NO_COLOR}" "Working tree or index have uncommitted changes. Will not upgrade any git branches from remote."
  echo -e "${RED_BACKGROUND}ERROR:"            "Working tree or index have uncommitted changes. Will not upgrade any git branches from remote.${NO_COLOR}"
  exit
fi

git fetch --all --tags --prune

# See https://stackoverflow.com/questions/4950725/how-can-i-see-which-git-branches-are-tracking-which-remote-upstream-branch
while read branch; do
  upstream=$(git rev-parse --abbrev-ref $branch@{upstream} 2>/dev/null)
  if [[ $? == 0 ]]; then
    if [[ "$branch" == "$current_branch" ]]; then
      git reset --hard "$upstream"
    else
      git branch -f "$branch" "$upstream"
    fi
  fi
done < <(git for-each-ref --format='%(refname:short)' refs/heads/*)
