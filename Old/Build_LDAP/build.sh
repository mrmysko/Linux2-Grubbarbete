#!/bin/bash

# Todo - Versioning, Tagga nya builds med högre nummer på nått sätt.
# Todo - Kolla om det ens finns uppdateringar innan ny build.

# Build new image
docker build --no-cache -t ldap_custom . 2>&1 | tee build.log