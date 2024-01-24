#!/bin/bash

# Decrypt backup (prompt for passphrase) and import it.

#DOMAIN
FILE="$1"
#LDAP_USER
#PASS
#PORT

ldapadd -x -c -w "${PASS:-"ldap_password"}" -H ldap://"${DOMAIN:-"localhost"}":"${PORT:-"389"}" -D "cn=${LDAP_USER:-"admin"},dc=hemlis,dc=com" -f "$FILE"
