#!/bin/bash

# Wordpress importerar bara en folder som heter samma som domän.

echo "Setup apache..."

# Silence aoache error.
echo "ServerName $DOMAIN" >> /etc/apache2/apache2.conf 

# Create apache wordpress config.
cat > /etc/apache2/sites-available/"$DOMAIN".conf << EOF
<VirtualHost *:80> 
    ServerName www.$DOMAIN
    ServerAlias $DOMAIN

    CustomLog /var/log/apache2/access.log combined

    Redirect permanent / https://$DOMAIN/
</VirtualHost>

<VirtualHost *:443>
    ServerName www.$DOMAIN
    ServerAlias $DOMAIN

    DocumentRoot /var/www/$DOMAIN

    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined

    SSLEngine on
    SSLCertificateFile /etc/ssl/certs/$DOMAIN.crt
    SSLCertificateKeyFile /etc/ssl/private/$DOMAIN.key
</VirtualHost>
EOF

# Check for a backup in /Import_DB, unpack that instead.
if [ -f Import_DB/"$DOMAIN".wp.tar.gz ]; then
    cd Import_DB || return
    echo "Importing Backup..."
    tar -xf "$DOMAIN".wp.tar.gz -C /var/www
    cd ..
else

# Install wordpress.
tar -xzf wordpress.tar.gz
#rm wordpress/wp-config.php
mv wordpress /var/www/"$DOMAIN"
rm wordpress.tar.gz

# Move plugins to folder.
mv authldap /var/www/"$DOMAIN"/wp-content/plugins

# Uninstall default plugins.
rm /var/www/"$DOMAIN"/wp-content/plugins/hello.php
rm -r /var/www/"$DOMAIN"/wp-content/plugins/akismet

# Give owner of wordpress to webserver.
chown -R www-data: /var/www/"$DOMAIN"

fi

# Install WP-CLI.
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Enable SSL
a2enmod ssl

# Enable wordpress.
a2dissite 000-default.conf
a2ensite "$DOMAIN".conf

# Remove itself after run.
rm "$0"