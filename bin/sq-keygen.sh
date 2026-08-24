#!/usr/bin/env bash

KEYDIR=${KEYDIR:-/Users/raphael/.ssh}
EMAIL=${EMAIL:-tech+infra@strengthinnumbers.business}
NAME=${NAME:-"SIN TECH INFRA"}

PASSWORD_FILE=${KEYDIR}/${EMAIL}-password.txt
SECRET_KEY_FILE=${KEYDIR}/${EMAIL}-secret.pgp
REVOCATION_CERT_FILE=${KEYDIR}/${EMAIL}-revocation-cert.pgp
PUBLIC_KEY_FILE=${KEYDIR}/${EMAIL}-public.pgp

FILES_EXIST="false"

if [ -e "${PASSWORD_FILE}" ]; then
    echo "File exists already: ${PASSWORD_FILE}"
    FILES_EXIST="true"
fi

if [ -e "${SECRET_KEY_FILE}" ]; then
    echo "File exists already: ${SECRET_KEY_FILE}"
    FILES_EXIST="true"
fi

if [ -e "${REVOCATION_CERT_FILE}" ]; then
    echo "File exists already: ${REVOCATION_CERT_FILE}"
    FILES_EXIST="true"
fi

if [ -e "${PUBLIC_KEY_FILE}" ]; then
    echo "File exists already: ${PUBLIC_KEY_FILE}"
    FILES_EXIST="true"
fi

if [ "false" != "${FILES_EXIST}" ]; then
    echo "Exiting because (some) file(s) exist(s) already."
    exit 1
fi

rnd.py > ${PASSWORD_FILE}

sq key generate \
    --can-authenticate \
    --can-encrypt=universal \
    --can-sign \
    --cipher-suite=mldsa87-ed448 \
    --encryption-algorithm=mlkem1024-x448 \
    --expiration=3y \
    --new-password-file="${PASSWORD_FILE}" \
    --output="${SECRET_KEY_FILE}" \
    --own-key \
    --profile=rfc9580 \
    --rev-cert="${REVOCATION_CERT_FILE}" \
    --signing-algorithm=mldsa87-ed448 \
    --name="${NAME}" \
    --email="${EMAIL}"

sq key delete \
    --cert-file="${SECRET_KEY_FILE}" \
    --output="${PUBLIC_KEY_FILE}"
