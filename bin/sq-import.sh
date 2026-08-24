#!/usr/bin/env bash

KEYDIR=${KEYDIR:-/Users/raphael/.ssh}
EMAIL=${EMAIL:-tech+infra@strengthinnumbers.business}
NAME=${NAME:-"SIN TECH INFRA"}

PASSWORD_FILE=${KEYDIR}/${EMAIL}-password.txt
SECRET_KEY_FILE=${KEYDIR}/${EMAIL}-secret.pgp
REVOCATION_CERT_FILE=${KEYDIR}/${EMAIL}-revocation-cert.pgp
PUBLIC_KEY_FILE=${KEYDIR}/${EMAIL}-public.pgp

sq key import "${SECRET_KEY_FILE}"

FINGERPRINT=`sq inspect "${SECRET_KEY_FILE}" | awk '$1 == "Fingerprint:" {print $2}'`

sq pki link authorize --unconstrained --all --cert="${FINGERPRINT}"

# # To delete secret keys from the keystore:
# sq key delete

# # The sq keystore stores secrets here:
# cd ~/Library/Application\ Support/pgp.cert.d

# # To delete public keys from the keystore:
# cd ~/Library/Application\ Support/org.Sequoia-PGP.sequoia/keystore/
