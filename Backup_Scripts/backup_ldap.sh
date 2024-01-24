#!/bin/bash

# ldapsearch vs slapd https://serverfault.com/a/584609

# Backup a ldap directory.

# Depends on ldap-utils

#DOMAIN
#LDAP_USER
#OUT_FILE
#PASS
#PORT

DB_DATE=$(date +'%m-%d-%R')
DB_NAME="$DB_DATE-${DOMAIN:-db}.ldif"

# Dumps DB.
ldapsearch -x -w "${PASS:-"ldap_password"}" -H ldap://"${DOMAIN:-"localhost"}":"${PORT:-"389"}" -D "cn=${LDAP_USER:-"admin"},${DN:-"dc=hemlis,dc=com"}" -b "${DN:-"dc=hemlis,dc=com"}" objectClass=top -LLL > "$DB_NAME"

