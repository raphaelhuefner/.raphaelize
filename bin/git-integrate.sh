#!/bin/bash

integration_branch=integration

current_changes="`git status -s --porcelain`"
current_branch="`git symbolic-ref --short -q HEAD`"

if [ -z "$current_branch" ]; then
  echo "Not on any branch. Abort integrating '$current_branch' into '$integration_branch'."
  exit
fi

if [ -n "$current_changes" ]; then
  git status
  echo "Working tree or index have uncommitted changes. Abort integrating '$current_branch' into '$integration_branch'."
  exit
fi

echo "Integrating '$current_branch' into '$integration_branch'."

git checkout $integration_branch
git pull -u origin $integration_branch:$integration_branch
git merge --no-ff --no-edit $current_branch
git checkout $current_branch
git push -u origin $current_branch:$current_branch $integration_branch:$integration_branch

