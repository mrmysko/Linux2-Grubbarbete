#!/bin/bash

# Arranges a domain into a search base.

IFS=. read -r -a DOMAIN_ARRAY <<< "$1"
unset IFS

for item in "${DOMAIN_ARRAY[@]}"; do
	DN=$DN"dc=$item,"
done

# Remove last comma
DN=${DN::-1}

echo "$DN"

# Vad vill vi ha för scripts?...

# Ett script som tar en csv-fil, och konverterar csvn till användare i den domänen? Hur vet vi vilket ou dom ska vara med i?
# En användare har cn/uid=,ou=,dc= minst.

# Script som byter domän på en databas.