#!/bin/bash

# Todo - Clean up tests

DOMAIN="hemlis.com"

# Backup storage directory 
BACKUP_DIR="/mnt/Backups/$DOMAIN"

# MySQL user
USER=root

# MySQL password 
PASSWORD=$(cat /home/mysko/Linux2-Grupparbete/Secrets/mysql_root_password.txt)

DB_DATE=$(date +'%m-%d-%y_%H-%M')
DB_NAME="$DB_DATE-${DOMAIN:-"db"}.sql"
ARCHIVE_NAME="$DB_NAME.tar.gz"
CONTAINER_IP=$(docker inspect -f '{{.NetworkSettings.Networks.defaultNet.IPAddress}}' mysql)

if [ $EUID -ne "0" ]; then
    sudo "$0"
    # This gets the exit code from the previously executed line, if script is not run with sudo privilegies,
    # the if-statement runs the script again with sudo. And then exit with that runs exit-code.
    exit $?
fi

if [ "$(docker container inspect -f '{{.State.Running}}' mysql)" = true ]; then

  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
  fi

  cd "$BACKUP_DIR" || exit 2;

  # Create a backup 
  mysqldump --add-drop-table --host="$CONTAINER_IP" -u "$USER" -p"$PASSWORD" --all-databases > "$DB_NAME"

  if [ $? -eq 0 ]; then
    echo 'Sql dump created' 
  else
    echo 'mysqldump return non-zero code' |  'No backup was created!'   
    exit 
  fi 

  # Compress backup 
  tar -czf "$ARCHIVE_NAME" "$DB_NAME"

  if [ $? -eq 0 ]; then
    echo 'The backup was successfully compressed' 
  else
    echo 'Error compressing backup' | 'Backup was not created!' 
    exit 
  fi 

  rm "$DB_NAME"

  # Encrypt backup
  openssl enc -aes-256-cbc -pbkdf2 -in "$ARCHIVE_NAME" -out "$ARCHIVE_NAME".crypt -pass file:/root/crypt.key

  rm "$ARCHIVE_NAME"

  echo 'Backup was successfully created'  

  # Send backup off-site
  scp -P 50 -i /root/backup.key "$ARCHIVE_NAME".crypt backup_user@hemlis.com:./Backups

  # Delete old backups 
  find . -type f -name \*.sql.tar.gz.crypt | sort -r | tail -n +15 | xargs -d '\n' rm 2>/dev/null
else
  echo "Container not found."; exit 1
fi