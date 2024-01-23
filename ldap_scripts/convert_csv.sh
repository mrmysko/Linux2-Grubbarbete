#!/bin/bash

# Todo - Split domain and edit dn.
# Todo - Om den här csvn ska importeras i en existerande db, hur vet jag vilka uidNr som inte är upptagna? Och vilka gid som är rätt?
# Todo - Kolla om ett värde är tomt, ta bort raden om det är de. LDAP kan inte importera om rader är tomma.
# Todo - Generera lösen för användare som inte har nått? Det sparas ju hashat så hur får dom reda på de sen?

# USAGE: convert_csv.sh <domain> <input.csv>

# Read users from a csv and format to an ldif file.
{
read -r LINE # Read first line for header.
readarray -d, -t HEADER < <(printf "%s" "$LINE") # Read line into an array.
    while IFS=',' read -r "${HEADER[@]}"; do # Use that array as field values.

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
        echo description: Temp Description
        echo sn: "$sn"
        echo givenName: "$givenName"
        echo mail: "$mail"
        echo telephoneNumber: "$telephoneNumber"
        echo userPassword:: e1NTSEF9ZS9RR2JHcGNrb0RhOEx0R1lOZFgvY1dObG9CaFNFZGs=
        echo gidNumber: "$gidNumber"
        echo
done 

} < "$1"

# e1NTSEF9ZS9RR2JHcGNrb0RhOEx0R1lOZFgvY1dObG9CaFNFZGs=
# uid cn sn givenName mail telephoneNumber uidNumber gidNumber userPassword description; do