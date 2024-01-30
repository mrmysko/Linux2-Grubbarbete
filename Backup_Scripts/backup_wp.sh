#!/bin/bash

# Put this file in /home/backup_user/

# Backup wordpress to a tar.gz archive.

DOMAIN="hemlis.com"
BACKUP_DIR="/mnt/Backups/wordpress/$DOMAIN"
CONTAINER_NAME="wordpress"

DB_DATE=$(date +'%m-%d-%y_%H-%M')
DB_NAME="$DB_DATE-$DOMAIN.wp.tar.gz"

# Check if container is running.
if [ "$(docker container inspect -f '{{.State.Running}}' $CONTAINER_NAME)" = true ]; then

    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Creating backup dir."
        mkdir "$BACKUP_DIR"
    fi

    cd "$BACKUP_DIR" || exit 1;

    docker cp wordpress:/var/www/"$DOMAIN" .

    # Archive volume.
    tar -czf "$DB_NAME" "$DOMAIN"
    rm -r "$DOMAIN"

    # Create md5 checksum
    md5sum "$DB_NAME" > "$DB_NAME".md5

    # Encrypt archive.
    openssl enc -aes-256-cbc -pbkdf2 -in "$DB_NAME" -out "$DB_NAME".crypt -pass file:/home/backup_user/crypto.key
    rm "$DB_NAME"

    chmod o-rwx "$DB_NAME".crypt

    # Send archive off-site.
    scp -P 50 -i ~/.ssh/backup.key "$DB_NAME"{.md5,.crypt} backup_user@hemlis.com:./Backups/wordpress/

    # Only keep 4 backups, wordpress themes etc. probably doesnt change that often.
    find . -type f -name \*.wp.tar.gz.crypt | sort -r | tail -n +5 | xargs -d '\n' rm 2>/dev/null
    find . -type f -name \*.wp.tar.gz.md5 | sort -r | tail -n +5 | xargs -d '\n' rm 2>/dev/null

else 
    echo "Error: Container not found."
    exit 1
fi
