#!/bin/bash

docker exec ldap ldapsearch -x -y /run/secrets/ldap_admin_password -D "cn=admin,dc=hemlis,dc=com" -b "dc=hemlis,dc=com" -LLL
