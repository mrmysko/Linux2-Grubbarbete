#!/bin/bash

# Decrypt backup an ldif backup and import it.

#DOMAIN
#LDAP_USER
#PASS
#PORT

usage() { echo "Usage: $0 -f <filename> -h <host>"; }

if [ $# -eq 0 ]; then
    echo "Argument required."; usage; exit 2;
fi

while getopts "f:h:" opt; do
    case ${opt} in
        f) FILE=${OPTARG} ;;
        h) DOMAIN=${OPTARG} ;;
        *) usage; exit 1 ;;
    esac
done

openssl enc -d -aes-256-cbc -pbkdf2 -in "$FILE" -out uncrypt.ldif -pass file:/root/crypt.key 2>/dev/null

ldapadd -x -c -w "${PASS:-"ldap_password"}" -H ldap://"${DOMAIN:-"localhost"}":"${PORT:-"389"}" \
    -D "cn=${LDAP_USER:-"admin"},dc=hemlis,dc=com" \
    -f uncrypt.ldif

rm uncrypt.ldif
