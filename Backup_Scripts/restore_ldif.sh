#!/bin/bash

# Decrypt an ldif backup and import it.

# Todo - Check if container is up.
# Todo - Allow to specify checksum-file.

#DOMAIN
#LDAP_USER
#PASS
#PORT

usage() { echo "Usage: $0 -f <filename> -h <host>"; }

# Check for root privilegies.
if [ $EUID -ne "0" ]; then
    echo "$0 is not running as root. Try using sudo."
    exit 3;
fi

if [ $# -eq 0 ]; then
    echo "Argument required."; usage; exit 2;
fi

while getopts "c:f:" opt; do
    case ${opt} in
        c) CONTAINER_NAME=${OPTARG} ;;
        f) FILE=${OPTARG} ;;
        *) usage; exit 1 ;;
    esac
done

BACKUP_PATH=$(dirname "$FILE")
DB_FILE="$(basename -- "$FILE" .crypt)"

openssl enc -d -aes-256-cbc -pbkdf2 -in "$FILE" -out "$DB_FILE" -pass file:/root/crypto.key 2>/dev/null

# Check if checksum match.
if md5sum --status -c "$BACKUP_PATH"/"$DB_FILE".md5; then

    echo "Checksum match, importing..."

    docker cp "$DB_FILE" ldap:.
    docker exec "${CONTAINER_NAME:-"ldap"}" ldapadd -x -c -w "${PASS:-"ldap_password"}" \
        -D "cn=${LDAP_USER:-"admin"},dc=hemlis,dc=com" \
        -f "$DB_FILE"

    rm "$DB_FILE"

else 
    echo "Checksum fail."
    rm "$DB_FILE"
    exit 1
fi
