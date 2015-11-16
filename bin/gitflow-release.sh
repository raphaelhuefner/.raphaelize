#!/bin/bash

NEW_VERSION=`php -R'list($name,$version)=explode("=", $argn); $parts=explode(".", $version); $parts[1]++; echo implode(".", $parts);' < git-flow-version`

git stash
git checkout -b release/$NEW_VERSION develop
./bump-version.sh $NEW_VERSION
git add git-flow-version
git commit -m"Bumped version number to $NEW_VERSION"
git checkout master
git merge --no-ff release/$NEW_VERSION -m"Merge branch 'release/$NEW_VERSION'"
git tag -a -m"release/$NEW_VERSION" $NEW_VERSION
git push --tags origin master
git checkout develop
git merge --no-ff release/$NEW_VERSION -m"Merge branch 'release/$NEW_VERSION' into develop"
git push origin develop

