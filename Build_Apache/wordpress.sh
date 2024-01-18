#!/bin/bash

# Create apache wordpress config file
cat > /etc/apache2/sites-available/"$SITENAME".conf << EOF
<VirtualHost *:80>
    DocumentRoot /var/www/$SITENAME

    ErrorLog /var/log/apache2/error.log
    CustomLog /var/log/apache2/access.log combined
</VirtualHost>
EOF

# Install wordpress
tar -xzf wordpress.tar.gz -C /var/www
rm wordpress.tar.gz

# Install WP-CLI
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Enable wordpress
a2dissite 000-default.conf
a2ensite "$SITENAME".conf

rm "$0"