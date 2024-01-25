#!/bin/bash

# ldapsearch vs slapd https://serverfault.com/a/584609

# Backup a ldap directory as an encrypted file.

# Depends on ldap-utils

# Todo - Lägg krypterings-nyckeln på ett säkert ställe.
# Todo - Rsynca backupen till off-site.

#DOMAIN
#LDAP_USER
#OUT_FILE
#PASS
#PORT

BACKUP_DIR=/mnt/Backups
CONTAINER_NAME="ldap"
DB_DATE=$(date +'%m-%d-%R')
DB_NAME="$DB_DATE-${DOMAIN:-"db"}.ldif"

# Check for root privilegies.
if [ $EUID -ne "0" ]; then
    sudo "$0"
    # This gets the exit code from the previously executed line, if script is not run with sudo privilegies,
    # the if-statement runs the script again with sudo. And then exit with that runs exit-code.
    exit $?
fi

if [ "$(docker container inspect -f '{{.State.Running}}' $CONTAINER_NAME)" = true ]; then

    # Dumps DB.
    ldapsearch -x -w "${PASS:-"ldap_password"}" -H ldap://"${DOMAIN:-"localhost"}":"${PORT:-"389"}" \
        -D "cn=${LDAP_USER:-"admin"},${DN:-"dc=hemlis,dc=com"}" \
        -b "${DN:-"dc=hemlis,dc=com"}" objectClass=top -LLL > "$DB_NAME"

    # Encrypt file.
    openssl enc -aes-256-cbc -pbkdf2 -in "$DB_NAME" -out "$BACKUP_DIR"/"$DB_NAME".crypt -pass file:/root/crypt.key

    # Mer lätt överskådligt, men skriver till filsystemet mellan kryptering.
    # Hur pipar jag output från ldapsearch till openssl -in ?
    rm "$DB_NAME"

    rsync "$BACKUP_DIR"/"$DB_NAME".crypt mysko@hemlis.com:50:/mnt/rsync_Backups/

    find "$BACKUP_DIR" -type f -name "*.ldif.crypt" | sort -r | tail -n +15 | xargs -d '\n' rm 2>/dev/null

    # rsync off-site.
    # rsync 
else 
    echo "Error: Container not found."
    exit 1
fi