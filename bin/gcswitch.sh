#!/usr/bin/env bash

CFG=$1

CREDENTIALS_SYMLINK=~/.config/gcloud/dynamic_default_credentials.json

CURRENTLY_ACTIVE=`gcloud config configurations list --format=json | jq -r 'map(select(.is_active)) | .[0].name'`

echo "Requested gcloud configuration '$CFG', currently active configuration is '$CURRENTLY_ACTIVE'."

if [[ "$CFG" != "$CURRENTLY_ACTIVE" ]]; then
	if [[ "$CFG" == "wife" ]]; then
		gcloud config configurations activate wife
		rm -f $CREDENTIALS_SYMLINK
		ln -s ~/.config/gcloud/legacy_credentials/WIFE@WIFE_BUSINESS.COM/adc.json $CREDENTIALS_SYMLINK
	elif [[ "$CFG" == "work" ]]; then
		gcloud config configurations activate work
		rm -f $CREDENTIALS_SYMLINK
		ln -s ~/.config/gcloud/application_default_credentials.json $CREDENTIALS_SYMLINK
		gcloud container clusters get-credentials $WORK_GCP_CLUSTERNAME_A --region europe-west3  --project $WORK_PROJECT_A
		gcloud container clusters get-credentials $WORK_GCP_CLUSTERNAME_B --region europe-west3  --project $WORK_PROJECT_B
	else
		echo >&2 "ERROR: unknown gcloud configuration: $CFG"
	fi
else
	echo "Requested gcloud configuration '$CFG' is already active, not doing anything."
fi

