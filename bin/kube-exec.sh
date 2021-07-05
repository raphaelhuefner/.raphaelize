#!/usr/bin/env bash

CLUSTER=$1
NAMESPACE=$2
DEPLOYMENT=$3
CONTAINER=$4
SHELL=$5
USER=$6

KXX="kubectl --cluster=$CLUSTER --namespace=$NAMESPACE --user=$USER"

PODNAME=`$KXX get pods --field-selector=status.phase=Running -l "app=$DEPLOYMENT" -o jsonpath="{.items[0].metadata.name}"`

$KXX exec $PODNAME -c $CONTAINER -t -i -- $SHELL

