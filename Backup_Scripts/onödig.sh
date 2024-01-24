#!/bin/bash

# ldapsearch vs slapd https://serverfault.com/a/584609

# Backup a ldap directory.

# Depends on ldap-utils

#DOMAIN
#LDAP_USER
#OUT_FILE
#PASS
#PORT

help() {
    echo "-d - Domain name, Default: localhost."
    echo "-p - Port,  Default: 389"
    echo "-u - User to authenticate with,  Default: readonly"
}

while getopts "hd:p:u:" o; do
    case "${o}" in
        h)
            help
            exit 0
            ;;
        d)
            DOMAIN=${OPTARG}

            IFS=. read -r -a DOMAIN_ARRAY <<< "$DOMAIN"
            unset IFS

            for item in "${DOMAIN_ARRAY[@]}"; do
                DN=$DN"dc=$item,"
            done

            # Remove last comma
            DN=${DN::-1}
            ;;
        p)
            PORT=${OPTARG}
            ;;
        u)
            USER=${OPTARG}
            ;;
        *)
            help
            ;;
    esac
done

DB=$(ldapsearch -x -w "${PASS:-"readonly"}" -H ldap://"${DOMAIN:-"localhost"}":"${PORT:-"389"}" -D "cn=${LDAP_USER:-"readonly"},${DN:-"dc=hemlis,dc=com"}" -b "${DN:-"dc=hemlis,dc=com"}" objectClass=top -LLL)

echo "$DB"
# Put $DB in a ldif file and encrypt it.