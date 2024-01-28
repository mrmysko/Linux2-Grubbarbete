#!/bin/bash

chown www-data:root config.cfg
mv config.cfg /var/lib/ldap-account-manager/config/config.cfg

rm "$0"

# Echoa det här till en fil istället så kan man använda secrets för lösen, och ändra variabler.
#password: {SSHA}D6AaX93kPmck9wAxNlq3GF93S7A= R7gkjQ==
#default: lam
#logLevel: 4
#logDestination: SYSLOG
#configDatabaseType: mysql
#configDatabaseServer: mysql
#configDatabasePort: 3306
#configDatabaseName: lam
#configDatabaseUser: lam_admin
#configDatabasePassword: lam_password
#license: 
