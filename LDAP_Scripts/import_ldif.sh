#!/bin/bash

# Todo - Om jag importerar en användare så har den en gidNumber, måste kolla om användarna är med i gruppen (gidNumber) \
#        om inte: Lägg till användarens uid till objectClass=posixGroup memberUid
#        Sök efter (&(objectClass=posixGroup)(gidNumber=$USER_GID)) testa om uid finns i memberUid. ldapmodify om den inte finns.

# Fel - LDAP_DOMAIN är en container variabel.
IFS=. read -r -a DOMAIN_ARRAY <<< "$LDAP_DOMAIN"
unset IFS

for item in "${DOMAIN_ARRAY[@]}"; do
	DN=$DN"dc=$item,"
done

# Remove last comma
DN=${DN::-1}

docker cp "$1" ldap:.
docker exec ldap ldapadd -c -x -y /run/secrets/ldap_admin_password -D "cn=admin,$DN" -f "$1"
docker exec ldap rm "$1"

# ldapadd -c -x -W -H ldap://localhost:389 -D "cn=admin,dc=hemlis,dc=com" -f defaultDB.ldif
