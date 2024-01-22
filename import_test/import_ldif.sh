#!/bin/bash

# Requires ldap-utils package.

docker cp "$1" ldap:.
docker exec ldap ldapadd -x -y /run/secrets/ldap_password -D "cn=admin,dc=hemlis,dc=com" -f "$1"
docker exec ldap rm "$1"
