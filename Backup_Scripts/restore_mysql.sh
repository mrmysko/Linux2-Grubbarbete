#!/bin/bash

# Unpacks an encrypted mysql-db to current folder.

DOMAIN="hemlis.com"
ARCHIVE_FILE="$DOMAIN".tar.gz

usage() { echo "Usage: $0 -f <filename>"; }

while getopts "f:" opt; do
    case "${opt}" in
        f) FILE=${OPTARG} ;;
        *) usage; exit 1 ;;
    esac
done

# Decrypt DB.
openssl enc -d -aes-256-cbc -pbkdf2 -in "$FILE" -out "$ARCHIVE_FILE" -pass file:/root/crypt.key

# Unpack it and remove archive.
tar -xzf "$ARCHIVE_FILE"
rm "$ARCHIVE_FILE"

# Import to mysql.
#mysql -u "$USER" -p"$PASSWORD" --host=$ < "$DB_NAME"