#!/bin/bash

if [[ ! -f /var/www/wordpress/wp-config.php ]]
then
cat > "wp-config.php" << EOF
<?php
// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', '$MYSQL_DATABASE' );

/** Database username */
define( 'DB_USER', '$MYSQL_USER' );

/** Database password */
define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );

/** Database hostname */
define( 'DB_HOST', '$DB_HOST' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );
EOF

curl https://api.wordpress.org/secret-key/1.1/salt/ >> wp-config.php

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

mv wp-config.php /var/www/wordpress/wp-config.php
fi

service apache2 start && tail --follow=name /var/log/apache2/error.log