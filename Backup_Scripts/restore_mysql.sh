#!/bin/bash

# Decrypt an encrypted mysql db.

# Todo - Allow to specify checksum-file.
# Todo - In case of a checksum fail, should the file be removed?

usage() { echo "Usage: $0 -f <filename>"; }

# Check for root privilegies.
if [ $EUID -ne "0" ]; then
    echo "$0 is not running as root. Try using sudo."
    exit 1;
fi

while getopts "c:f:" opt; do
    case "${opt}" in
        c) CHECKSUM_FILE=${OPTARG} ;;
        f) FILE=${OPTARG} ;;
        *) usage; exit 2 ;;
    esac
done
#shift $((OPTIND +1))

BACKUP_PATH="$(dirname "$FILE")"
ARCHIVE_FILE=$(basename -- "$FILE" .crypt)

# Decrypt DB.
openssl enc -d -aes-256-cbc -pbkdf2 -in "$FILE" -out "$ARCHIVE_FILE" -pass file:/root/crypto.key

tar --same-owner -xzf "$ARCHIVE_FILE"

DB_FILE=$(basename -- "$ARCHIVE_FILE" .tar.gz)

if md5sum --status -c "${CHECKSUM_FILE:-"$BACKUP_PATH"/"$DB_FILE.md5"}"; then
    echo "Checksum match."
else 
    echo "Checksum fail."
    rm "$DB_FILE"
    rm "$ARCHIVE_FILE"; exit 3;
fi

rm "$ARCHIVE_FILE"

# Import to mysql.
#docker cp 
#docker exec mysql mysql -u "$USER" -p"$PASSWORD" --host=$ < "$DB_NAME"