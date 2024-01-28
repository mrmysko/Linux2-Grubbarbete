#!/bin/bash

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
BACKUP_DIR="/mnt/Backups/$DOMAIN"
CONTAINER_NAME="ldap"

DB_DATE=$(date +'%m-%d-%y_%H-%M')

DB_NAME="$DB_DATE-${DOMAIN:-"db"}.ldif"

# Check for root privilegies.
if [ $EUID -ne "0" ]; then
    sudo "$0"
    # This gets the exit code from the previously executed line, if script is not run with sudo privilegies,
    # the if-statement runs the script again with sudo. And then exit with that runs exit-code.
    exit $?
fi

if [ "$(docker container inspect -f '{{.State.Running}}' $CONTAINER_NAME)" = true ]; then

    if [ ! -d "$BACKUP_DIR" ]; then
        echo "Creating backup dir."
        mkdir "$BACKUP_DIR"
    fi

    cd "$BACKUP_DIR" || exit 1;

    # Dumps DB.
    ldapsearch -x -w "${PASS:-"ldap_password"}" -H ldap://"${DOMAIN:-"localhost"}":"${PORT:-"389"}" \
        -D "cn=${LDAP_USER:-"admin"},${DN:-"dc=hemlis,dc=com"}" \
        -b "${DN:-"dc=hemlis,dc=com"}" objectClass=top -LLL > "$DB_NAME"

    # Encrypt file.
    openssl enc -aes-256-cbc -pbkdf2 -in "$DB_NAME" -out "$DB_NAME".crypt -pass file:/root/crypt.key

    # Mer lätt överskådligt, men skriver till filsystemet mellan kryptering.
    # Hur pipar jag output från ldapsearch till openssl -in ?
    rm "$DB_NAME"

    # Send backup off-site.
    scp -P 50 -i /root/backup.key "$DB_NAME".crypt backup_user@hemlis.com:./Backups/

    find . -type f -name \*.ldif.crypt | sort -r | tail -n +15 | xargs -d '\n' rm 2>/dev/null

else 
    echo "Error: Container not found."
    exit 1
fi