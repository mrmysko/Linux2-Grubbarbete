#!/bin/bash

# Run everything in this if if the file /usr/old doesnt exist.
if [[ ! -f /usr/old.file ]]
then
cat > "wp-config.php" << EOF
<?php

define( 'DB_NAME', '$MYSQL_DATABASE' );
define( 'DB_USER', '$MYSQL_USER' );
define( 'DB_PASSWORD', '$MYSQL_PASSWORD' );
define( 'DB_HOST', '$DB_HOST' );

define( 'DB_CHARSET', 'utf8' );
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

# Create file signifying that the container has run before.
touch /usr/old.file
fi

service apache2 start && tail --follow=name /var/log/apache2/error.log