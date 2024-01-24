#!/bin/bash

# Backup on the entire ldap database.

usage() { echo "Usage: $0 [options -ogu]" 1>&2; exit 0; }

scope=""
while getopts "hogu" o; do
    case "${o}" in
        h)
            usage
            ;;
        o)
            scope="objectClass=organizationalUnit"
            ;;
        g)
            scope="objectClass=posixGroup"
            ;;
        u)
            scope="objectClass=posixAccount"
            ;;
        *)
            usage
            ;;
    esac
done

docker exec ldap ldapsearch -x -y /run/secrets/ldap_readonly_password -D "cn=readonly,dc=hemlis,dc=com" -b "dc=hemlis,dc=com" -LLL ${scope:-"objectClass=top"}
