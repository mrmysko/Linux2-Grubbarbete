#!/bin/bash

# Todo - Versioning, Tagga nya builds med högre nummer på nått sätt.
# Todo - Kolla om det ens finns uppdateringar innan ny build.

# Check for wordpress update
wget -q https://wordpress.org/latest.tar.gz.md5

if [[ $? && ! $(cat latest.tar.gz.md5) = $(md5sum wordpress.tar.gz | cut -d ' ' -f 1) ]]; then
    # Download new wordpress if md5 doesnt match.
    wget -q https://wordpress.org/latest.tar.gz -O ./wordpress.tar.gz
fi

rm latest.tar.gz.md5

# Build new image
docker build --no-cache -t wp_custom . 2>&1 | tee build.log