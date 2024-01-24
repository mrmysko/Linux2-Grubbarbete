#!/bin/bash

# Backup a ldap directory and config in a date-tagged tar.gz archive.

# Depends on ldap-utils

#DOMAIN
#LDAP_USER
#OUT_FILE
#PASS
#PORT
#SCOPE

DB=$(ldapsearch -x -w "${PASS:-"readonly"}" -H ldap://"${DOMAIN:-localhost}":"${PORT:-"389"}" -D "cn=${LDAP_USER:-"readonly"},dc=hemlis,dc=com" -b "dc=hemlis,dc=com" objectClass="${SCOPE:-"top"}" -LLL)

# Put $DB in a ldif file and encrypt it.

help() {
    printf "-d - Domain name, Default: localhost. \n
    -p - Port,  Default: 389 \n
    -s - Scope of backup, Default: top \n
    -u - User to authenticate with,  Default: readonly"
}

#<date>_<domain>_LDAP_db.tar.gz
# README with file locations.