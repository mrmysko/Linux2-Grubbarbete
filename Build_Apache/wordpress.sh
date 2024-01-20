#!/bin/bash

# Create apache wordpress config file.
cat > /etc/apache2/sites-available/"$DOMAIN".conf << EOF
<VirtualHost *:80> 
    ServerName $DOMAIN
    ServerAlias www.$DOMAIN

    Redirect permanent / https://example.com/
</VirtualHost>

<VirtualHost *:443>
    DocumentRoot /var/www/$DOMAIN

    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>
EOF

# Install wordpress.
tar -xzf wordpress.tar.gz
mv wordpress /var/www/"$DOMAIN"
rm wordpress.tar.gz

# Move plugins to folder.
mv authldap /var/www/"$DOMAIN"/wp-content/plugins
mv authorizer /var/www/"$DOMAIN"/wp-content/plugins
mv ldap-login-for-intranet-sites /var/www/"$DOMAIN"/wp-content/plugins

# Uninstall default plugins.
rm /var/www/"$DOMAIN"/wp-content/plugins/hello.php
rm -r /var/www/"$DOMAIN"/wp-content/plugins/akismet

# Install WP-CLI.
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Enable wordpress.
a2dissite 000-default.conf
a2ensite "$DOMAIN".conf

# Remove itself after run.
rm "$0"