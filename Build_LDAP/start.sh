#!/bin/bash

# Run everything in this if if the file /usr/old doesnt exist.
if [[ ! -f /usr/old.file ]]; then

    # Signify that the fcontainer has run before.
    touch /usr/old.file
fi

service slapd start && tail -f /dev/null