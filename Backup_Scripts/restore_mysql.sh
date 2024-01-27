#!/bin/bash

# Restores an encrypted mysql-backup.

usage() { echo "Usage: $0 -f <filename>"; }

while getopts "f:" opt; do
    case "${opt}" in
        f) FILE=${OPTARG} ;;
        *) usage; exit 1 ;;
    esac
done

# Decrypt DB.
openssl -in "$FILE" -out "$ARCHIVE_FILE"

# Unpack it.
tar -xf "$ARCHIVE_FILE"

# Import to mysql.
mysql -u "$USER" -p"$PASSWORD" --host=$ < "$DB_NAME"