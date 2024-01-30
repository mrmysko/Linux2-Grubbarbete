#!/bin/bash

# Decrypt a wordpress db.

# Todo - Allow to specify checksum-file.
# Todo - In case of a checksum fail, should the file be removed?

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

#ARCHIVE_FILE=$(sed 's/\.[^.]*$//' "$FILE")

BACKUP_PATH=$(dirname "$FILE")
ARCHIVE_FILE=$(basename -- "$FILE" .crypt)

openssl enc -d -aes-256-cbc -pbkdf2 -in "$FILE" -out "$ARCHIVE_FILE" -pass file:/root/crypto.key

if md5sum --status -c "$BACKUP_PATH"/"$ARCHIVE_FILE".md5; then
    echo "Checksum match."
else
    echo "Checksum fail."
    rm "$ARCHIVE_FILE"
fi