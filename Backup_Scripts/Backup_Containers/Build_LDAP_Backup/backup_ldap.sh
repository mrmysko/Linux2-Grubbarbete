#!/bin/bash

# ldapsearch vs slapd https://serverfault.com/a/584609

# Backup a ldap directory as an encrypted file.

# Depends on ldap-utils

# Inte adapted för docker-container än.

DB_DATE=$(date +'%m-%d-%R')
DB_NAME="$DB_DATE-${DOMAIN:-"db"}.ldif"

# Dumps DB.
ldapsearch -x -w "${PASS:-"ldap_password"}" \
    -D "cn=${LDAP_USER:-"admin"},${DN:-"dc=hemlis,dc=com"}" \
    -b "${DN:-"dc=hemlis,dc=com"}" objectClass=top -LLL > "$DB_NAME"