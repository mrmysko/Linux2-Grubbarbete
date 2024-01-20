#!/bin/bash

echo "Generating wp-conf.php"

# Create wp-config.php
cat > "wp-config.php" << EOF
<?php

define( 'DB_NAME', '$MYSQL_DATABASE' );
define( 'DB_USER', '$MYSQL_USER' );
define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );
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
mv wp-config.php /var/www/"$DOMAIN"/wp-config.php

wp --allow-root --path=/var/www/"$DOMAIN" core install --url=www."$DOMAIN" --title=Homepage --admin_user="$WP_ADMIN_USER" --admin_email="$WP_ADMIN_USER"@"$DOMAIN" --admin_password="$WP_ADMIN_PASS" --skip-email

# Remove itself.
rm "$0"