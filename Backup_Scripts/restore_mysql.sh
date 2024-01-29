#!/bin/bash

# Decrypt an encrypted mysql db.

usage() { echo "Usage: $0 -f <filename>"; }

# Check for root privilegies.
if [ $EUID -ne "0" ]; then
    echo "$0 is not running as root. Try using sudo."
    exit 2;
fi

while getopts "f:" opt; do
    case "${opt}" in
        f) FILE=${OPTARG} ;;
        *) usage; exit 1 ;;
    esac
done

ARCHIVE_FILE="$(basename -- "$FILE" .crypt)"

# Decrypt DB.
openssl enc -d -aes-256-cbc -pbkdf2 -in "$FILE" -out "$ARCHIVE_FILE" -pass file:/root/crypto.key

# Unpack it and remove archive.
tar -xzf "$ARCHIVE_FILE"
rm "$ARCHIVE_FILE"

# Import to mysql.
#mysql -u "$USER" -p"$PASSWORD" --host=$ < "$DB_NAME"