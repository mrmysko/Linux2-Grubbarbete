#!/bin/bash

chown www-data:root config.cfg
mv config.cfg /var/lib/ldap-account-manager/config/config.cfg

rm "$0"