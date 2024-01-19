#!/bin/bash

# Run everything in this if if the file /usr/old doesnt exist.
if [[ ! -f /usr/old.file ]]; then
    apt update && apt install ldap-utils slapd

    # Signify that the fcontainer has run before.
    touch /usr/old.file
fi

service slapd start && tail -f /dev/null