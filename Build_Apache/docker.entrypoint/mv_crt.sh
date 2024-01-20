#!/bin/bash

# Todo - Fix so this only runs at first run...
# If it checks for old.file, wp_config.sh could run first, create the file and this NEVER runs.

# Move certificate files to the right place.
chmod 400 "$DOMAIN".key
chmod 444 "$DOMAIN".crt

mv "$DOMAIN".key /etc/ssl/private/
mv "$DOMAIN".crt /etc/ssl/certs/