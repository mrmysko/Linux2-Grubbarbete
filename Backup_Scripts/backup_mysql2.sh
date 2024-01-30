#!/bin/bash

# Put this file in /home/backup_user/

# Todo - Clean up tests

# Det här funkar inte eftersom kali kör mariadb och mysqldumpar inte likadana databas.

DOMAIN="hemlis.com"

# Backup storage directory 
BACKUP_DIR="/mnt/Backups/mysql/$DOMAIN"

# MySQL user
USER=root

# MySQL password 

# How to expose this file to backup_user, but not give everyone access...only root can read this atm
# PASSWORD_FILE="/home/backup_user/Secrets/mysql_root_password.txt"
PASSWORD=mysql_password

DB_DATE=$(date +'%m-%d-%y_%H-%M')
DB_NAME="$DB_DATE-${DOMAIN:-"db"}.sql"
ARCHIVE_NAME="$DB_NAME.tar.gz"

# Check if container is running.
if [ "$(docker container inspect -f '{{.State.Running}}' mysql)" = true ]; then

  if [ ! -d "$BACKUP_DIR" ]; then
    mkdir "$BACKUP_DIR"
  fi

  cd "$BACKUP_DIR" || exit 2;

  # Create a backup 
  docker exec mysql mysqldump --add-drop-table -u "$USER" -p"$PASSWORD" --all-databases \
    --ignore-table=mysql.innodb_index_stats \
    --ignore-table=mysql.innodb_table_stats > "$DB_NAME"

  # Create md5 checksum
  md5sum "$DB_NAME" > "$DB_NAME".md5

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
  openssl enc -aes-256-cbc -pbkdf2 -in "$ARCHIVE_NAME" -out "$ARCHIVE_NAME".crypt -pass file:/home/backup_user/crypto.key

  rm "$ARCHIVE_NAME"

  chmod o-rwx "$ARCHIVE_NAME".crypt

  echo 'Backup was successfully created'  

  # Send backup off-site
  scp -P 50 -i ~/.ssh/backup.key "$ARCHIVE_NAME"{.md5,.crypt} backup_user@annandoman.com:./Backups/mysql/

  # Delete old backups 
  find . -type f -name \*.sql.tar.gz.crypt | sort -r | tail -n +15 | xargs -d '\n' rm 2>/dev/null
  find . -type f -name \*.sql.tar.gz.md5 | sort -r | tail -n +15 | xargs -d '\n' rm 2>/dev/null

else
  echo "Container not found."; exit 1
fi