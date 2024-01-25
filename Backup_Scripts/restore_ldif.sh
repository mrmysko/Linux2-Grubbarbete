#!/bin/bash

# Decrypt backup (prompt for passphrase) and import it.

#DOMAIN
FILE="$1"
#LDAP_USER
#PASS
#PORT

# Todo - Avkryptera med openssl.
# Todo - Argument som pekar på vilken backup man vill restora.
# Todo - 

openssl enc -d -aes-256-cbc -pbkdf2 -in "$FILE" -out uncrypt.ldif -pass file:/root/crypt.key

ldapadd -x -c -w "${PASS:-"ldap_password"}" -H ldap://"${DOMAIN:-"localhost"}":"${PORT:-"389"}" \
    -D "cn=${LDAP_USER:-"admin"},dc=hemlis,dc=com" \
    -f uncrypt.ldif

rm uncrypt.ldif
