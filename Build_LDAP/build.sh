#!/bin/bash

# Todo - Versioning, Tagga nya builds med högre nummer på nått sätt.
# Todo - Kolla om det ens finns uppdateringar innan ny build.

# Check for root privilegies.
if [ $EUID -ne "0" ]; then
    sudo "$0"
    # This gets the exit code from the previously executed line, if script is not run with sudo privilegies,
    # the if-statement runs the script again with sudo. And then exit with that runs exit-code.
    exit $?
fi

# Build new image
docker build --no-cache -t ldap_custom . 2>&1 | tee build.log