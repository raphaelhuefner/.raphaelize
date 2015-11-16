#!/bin/bash

CURRENT_BRANCH=`git rev-parse --abbrev-ref HEAD`
git push -u origin $CURRENT_BRANCH
git checkout develop
git pull
git merge --no-ff $CURRENT_BRANCH -m"Merge branch '$CURRENT_BRANCH' into develop"
git push -u origin develop


