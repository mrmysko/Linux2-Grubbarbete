#!/bin/bash

echo "Setup phpLDAPadmin..."

# Arranges a domain into bind_id.
IFS=. read -r -a DOMAIN_ARRAY <<< "$DOMAIN"
unset IFS

for item in "${DOMAIN_ARRAY[@]}"; do
	DN=$DN"dc=$item,"
done

# Remove last comma
DN=${DN::-1}

PHP_LDAP_CONF="/etc/phpldapadmin/config.php"
# Replace values in PLA config.php
sed -i "/^\$servers->setValue('server','name'/s/'[^']*'/'$DOMAIN LDAP Server'/3" $PHP_LDAP_CONF

# Hur får jag ut hostnamet på en docker container.
sed -i "/^\$servers->setValue('server','host'/s/'[^']*'/'ldap'/3" $PHP_LDAP_CONF
sed -i "/^\$servers->setValue('server','base',array/s/'[^']*'/'$DN'/3" $PHP_LDAP_CONF 

sed -i "/^\$servers->setValue('login','bind_id'/s/'[^']*'/'cn=$LDAP_ADMIN_USERNAME,$DN'/3" $PHP_LDAP_CONF

cat '$config->custom->appearance['hide_template_warning'] = true;' >> $PHP_LDAP_CONF

rm "$0"