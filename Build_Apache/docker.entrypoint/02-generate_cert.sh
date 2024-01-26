#!/bin/bash

# Todo - Explain this.
openssl genrsa -out "$DOMAIN".key 4096
openssl req -new -out "$DOMAIN".csr -sha256 -key "$DOMAIN".key \
    -subj "/C=SE/O=$DOMAIN/CN=*.$DOMAIN"
openssl x509 -req -in "$DOMAIN".csr -days 365 -signkey "$DOMAIN".key -out "$DOMAIN".crt -outform PEM

# Move certificate files to the right place.
mv "$DOMAIN".key /etc/ssl/private/
mv "$DOMAIN".crt /etc/ssl/certs/

# Remove itself.
rm "$DOMAIN".csr
rm "$0"