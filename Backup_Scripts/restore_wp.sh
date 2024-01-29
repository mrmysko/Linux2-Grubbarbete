#!/bin/bash

# Decrypt a wordpress db.

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

openssl enc -d -aes-256-cbc -pbkdf2 -in "$FILE" -out "$(basename -- "$FILE" .crypt)" -pass file:/root/crypto.key
