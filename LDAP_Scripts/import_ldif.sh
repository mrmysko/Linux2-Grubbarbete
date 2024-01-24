#!/bin/bash

# Todo - Om jag importerar en användare så har den en gidNumber, måste kolla om användarna är med i gruppen (gidNumber) \
#        om inte: Lägg till användarens uid till objectClass=posixGroup memberUid
#        Sök efter (&(objectClass=posixGroup)(gidNumber=$USER_GID)) testa om uid finns i memberUid. ldapmodify om den inte finns.

docker cp "$1" ldap:.
docker exec ldap ldapadd -c -x -y /run/secrets/ldap_admin_password -D "cn=admin,dc=hemlis,dc=com" -f "$1"
docker exec ldap rm "$1"
