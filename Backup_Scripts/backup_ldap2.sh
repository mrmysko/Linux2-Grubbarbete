#!/bin/bash

# Put this file in /home/backup_user/

# ldapsearch vs slapd https://serverfault.com/a/584609

# Backup a ldap directory as an encrypted file, both local and off-site.

# Depends on ldap-utils

# Todo - Lägg krypterings-nyckeln på ett säkert ställe.
# Todo - Mer dynamiskt, specificera host,port,utfil, etc...med getopts.
# Todo - Failsafes, testa så saker fungerar och hantera errors. Är remote-servern nere? Gör en retry kanske?
# Todo - scp skapar inte en domän-folder på remoten. Det blir en fil som heter domänen istället.

#LDAP_USER
#PASSWORD
#PORT

DOMAIN="hemlis.com"
BACKUP_DIR="/mnt/Backups/ldap/$DOMAIN"
CONTAINER_NAME="ldap"

DB_DATE=$(date +'%m-%d-%y_%H-%M')

DB_NAME="$DB_DATE-${DOMAIN:-"db"}.ldif"

if [ "$(docker container inspect -f '{{.State.Running}}' $CONTAINER_NAME)" = true ]; then

    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Creating backup dir."
        mkdir "$BACKUP_DIR"
    fi

    cd "$BACKUP_DIR" || exit 1;

    # Plockar ut dbn, utan host.
    docker exec ldap ldapsearch -x -w "${PASS:-"ldap_password"}" \
        -D "cn=${LDAP_USER:-"admin"},${DN:-"dc=hemlis,dc=com"}" \
        -b "${DN:-"dc=hemlis,dc=com"}" objectClass=top -LLL > "$DB_NAME"

    # Create md5 checksum
    md5sum "$DB_NAME" > "$DB_NAME".md5

    # Encrypt file.
    openssl enc -aes-256-cbc -pbkdf2 -in "$DB_NAME" -out "$DB_NAME".crypt -pass file:/home/backup_user/crypto.key

    # Mer lätt överskådligt, men skriver till filsystemet mellan kryptering.
    # Hur pipar jag output från ldapsearch till openssl -in ?
    rm "$DB_NAME"

    chmod o-rwx "$DB_NAME".crypt

    # Send backup off-site.
    scp -P 50 -i ~/.ssh/backup.key "$DB_NAME"{.md5,.crypt} backup_user@hemlis.com:./Backups/ldap/

    find . -type f -name \*.ldif.crypt | sort -r | tail -n +15 | xargs -d '\n' rm 2>/dev/null
    find . -type f -name \*.ldif.md5 | sort -r | tail -n +15 | xargs -d '\n' rm 2>/dev/null


else 
    echo "Error: Container not found."
    exit 1
fi
