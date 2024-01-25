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

# Inte adapted för docker-container än.

DB_DATE=$(date +'%m-%d-%R')
DB_NAME="$DB_DATE-${DOMAIN:-"db"}.ldif"

if [ "$(docker container inspect -f '{{.State.Running}}' ldap)" = true ]; then

    # Dumps DB.
    ldapsearch -x -w "${PASS:-"ldap_password"}" -H ldap://"${DOMAIN:-"localhost"}":"${PORT:-"389"}" \
        -D "cn=${LDAP_USER:-"admin"},${DN:-"dc=hemlis,dc=com"}" \
        -b "${DN:-"dc=hemlis,dc=com"}" objectClass=top -LLL > "$DB_NAME"

    # Encrypt file.
    openssl enc -aes-256-cbc -pbkdf2 -in "$DB_NAME" -out /mnt/Backups/"$DB_NAME".crypt -pass file:/root/crypt.key

    # Mer lätt överskådligt, men skriver till filsystemet mellan kryptering.
    # Hur pipar jag output från ldapsearch till openssl -in ?
    rm "$DB_NAME"

    find /mnt/Backups -type f -name "*.ldif.crypt" | sort -r | tail -n +15 | xargs -d '\n' rm 2>/dev/null

    # rsync off-site.
    # rsync 
else 
    echo "Error: Container not found."
    exit 1
fi