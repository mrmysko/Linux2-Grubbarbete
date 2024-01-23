#!/bin/bash

# Todo - Split domain and edit dn.
# Todo - Om den här csvn ska importeras i en existerande db, hur vet jag vilka uidNr som inte är upptagna? Och vilka gid som är rätt grupper.

# USAGE: import_from_csv.sh <domain> <input.csv> <output.ldif>

# Read users from a csv and format to an ldif file.

while IFS=',' read -r uid cn sn givenName mail telephoneNumber uidNumber gidNumber userPassword description; do

echo dn: uid="$uid",ou=Users,dc=hemlis,dc=com
echo objectClass: posixAccount
echo objectClass: inetOrgPerson
echo objectClass: organizationalPerson
echo objectClass: person
echo uid: "$uid"
echo cn: "$cn"
echo loginShell: /bin/false
echo homeDirectory: /home/"$uid"
echo uidNumber: "$uidNumber"
echo description: "$description"
echo sn: "$sn"
echo givenName: "$givenName"
echo mail: "$mail"
echo telephoneNumber: "$telephoneNumber"
echo userPassword:: "$userPassword"
echo gidNumber: "$gidNumber"
echo

done < "$1" > "$2"

# e1NTSEF9ZS9RR2JHcGNrb0RhOEx0R1lOZFgvY1dObG9CaFNFZGs=