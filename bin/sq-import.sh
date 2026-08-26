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

# # Secret keys in the keystore are held here:
# cd ~/Library/Application\ Support/org.Sequoia-PGP.sequoia/keystore/

# # The sq keystore stores public keys (certs) here:
# cd ~/Library/Application\ Support/pgp.cert.d
#
# To "delete" public keys, you can "hack" the index and cache DBs with `sqlite3`:
#
# sqlite3 _sequoia_cert_store_index_v1_on_*.sqlite
#
# sqlite> .headers on
# sqlite> .tables
# sqlite> SELECT * FROM userids;
# sqlite> SELECT * FROM keys;
# sqlite> SELECT * FROM certs;
# sqlite> SELECT * FROM certd_tag;
# sqlite> DELETE FROM keys WHERE cert_fingerprint = "0123abc...";
# sqlite> DELETE FROM certs WHERE cert_fingerprint = "0123abc...";
# sqlite> DELETE FROM userids WHERE cert_fingerprint = "0123abc...";
# sqlite> DELETE FROM certd_tag WHERE ???;
# sqlite> .exit;
#
#
# sqlite3 _sequoia_signature_verification_cache_v1_on_*.sqlite
#
# sqlite> .headers on
# sqlite> .tables
# sqlite> SELECT * FROM entries;
# sqlite> DELETE FROM entries WHERE ???;
# sqlite> .exit;
#
#

# # You can double-check all those file system paths with this:
# sq config inspect paths
