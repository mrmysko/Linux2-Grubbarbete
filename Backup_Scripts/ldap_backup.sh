#!/bin/bash

# Depends on ldap-utils


# OK, de här börjar i fel ände...få backup att funka först.
DOMAIN="localhost"
PORT=389

while getopts "hdpsu" o; do
    case "${o}" in
        h)
            help
            ;;
        s)
            if $o 
            scope="objectClass=organizationalUnit"
            ;;
        u)
            USER=$o
    esac
done

echo "ldapsearch -x -W \
    --hostname ${DOMAIN:-"localhost"} \
    -p ${PORT:-"389"} \
    -D "cn=${USER:-"readonly"},dc=hemlis,dc=com" \
    -b "dc=hemlis,dc=com" \
    -LLL objectClass=${SCOPE:-"top"}"

help() {
    printf "-d - Domain name, Default: localhost. \n
    -p - Port,  Default: 389 \n
    -s - Scope of backup, Default: top \n
    -u - User to authenticate with,  Default: readonly"
}