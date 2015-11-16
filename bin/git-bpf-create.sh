#!/bin/bash

# get command line parameter
NEW_BRANCH_NAME=$1

echo "fetching lastest state of affairs from server, especially tags"
git fetch --tags

echo "get latest tag from origin/master branch:"
LAST_MASTER_TAG=`git describe --tags --abbrev=0 origin/master`

echo $LAST_MASTER_TAG

echo "create new branch $1 from $LAST_MASTER_TAG"
git checkout -b $1 $LAST_MASTER_TAG

