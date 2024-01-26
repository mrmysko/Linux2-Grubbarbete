#!/bin/bash

# Waiting for mysql to restart on first boot.
sleep 10

echo "Generating wp-conf.php"

# Create wp-config.php
cat > "wp-config.php" << EOF
<?php

define( 'DB_NAME', '$MYSQL_DATABASE' );
define( 'DB_USER', '$MYSQL_USER' );
define( 'DB_PASSWORD', '$(cat "$WP_ADMIN_PASSWORD")' );
define( 'DB_HOST', '$MYSQL_DB_HOST' );
define( 'DB_CHARSET', 'utf8' );
define( 'DB_COLLATE', '' );
EOF

curl -s https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php

cat >> "wp-config.php" << "EOF"

$table_prefix = 'wp_';
define( 'WP_DEBUG', false );

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
    define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
EOF

# Move file to wordpress.
chown www-data: wp-config.php
mv wp-config.php /var/www/"$DOMAIN"/wp-config.php

echo "Creating Wordpress admin."
wp --allow-root --path=/var/www/"$DOMAIN" core install --url=www."$DOMAIN" --title=Homepage --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_USER"@"$DOMAIN" --admin_password="$(cat "$WP_ADMIN_PASSWORD")" --skip-email
wp --allow-root --path=/var/www/"$DOMAIN" plugin activate authldap

# Remove itself.
rm "$0"