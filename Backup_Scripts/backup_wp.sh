#!/bin/bash

# Backup wordpress to a tar.gz archive.

# Todo - Volym-path tas ut från ett volym-namn, ta det från ett container-namn istället.

DOMAIN="hemlis.com"
BACKUP_DIR="/mnt/Backups/$DOMAIN"
CONTAINER_NAME="wordpress"
VOL_NAME="wp_data"

VOL_PATH=$(docker inspect -f '{{.Mountpoint}}' $VOL_NAME)
DB_DATE=$(date +'%m-%d-%y_%H-%M')
DB_NAME="$DB_DATE-$DOMAIN.wp.tar.gz"

# Check for root privilegies.
if [ $EUID -ne "0" ]; then
    sudo "$0"
    # This gets the exit code from the previously executed line, if script is not run with sudo privilegies,
    # the if-statement runs the script again with sudo. And then exit with that runs exit-code.
    exit $?
fi

# Check if container is running.
if [ "$(docker container inspect -f '{{.State.Running}}' $CONTAINER_NAME)" = true ]; then

    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Creating backup dir."
        mkdir "$BACKUP_DIR"
    fi

    cd "$BACKUP_DIR" || exit 1;

    # Archive volume.
    tar -czf "$DB_NAME" -C "$VOL_PATH" "$DOMAIN"

    # Send archive off-site.
    #scp -P 50 -i /root/backup.key "$DB_NAME" backup_user@hemlis.com:./Backups/

    # Only keep 4 backups, wordpress themes etc. probably doesnt change that often.
    #find . -type f -name \*.wp.tar.gz | sort -r | tail -n +5 | xargs -d '\n' rm 2>/dev/null

else 
    echo "Error: Container not found."
    exit 1
fi