<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** MySQL database username */
define( 'DB_USER', 'betterme' );

/** MySQL database password */
define( 'DB_PASSWORD', 'password' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '0=PP?G%HrAc0yD<w;ZmcI{.?c>W-6,jzk6SPt|T-x^,a7#EC; /S48%oNrOn/2XV');
define('SECURE_AUTH_KEY',  'ET`AZ_.fnX[^O^dy1*4Y#NDr9#|^5?8YyYT?4(cWU1ld%-#x=Gi*Xdu2WU@KZmr&');
define('LOGGED_IN_KEY',    '+=*V?EI1m<480bjU]%!KCswM@qLF2^PF|6Vd:1xV|3|ymf8EED_^VE4y$^u(K21[');
define('NONCE_KEY',        'x,|#9L]haCtlY zUQv-K .$no+5fBKon_}rRNFYb-.n]6jQL/nqc%HSV=Ukx,Sx&');
define('AUTH_SALT',        'i?C`h28Sx5^Dvij!B<V6@|gc)b~vLOE>)8qL)+c5M~|1)=3k/Ur${n&LY]=s>EAM');
define('SECURE_AUTH_SALT', 'K/L vf+?-U<x&DJIe2MNQ-9k67]#y+_m!@}_=akOl|cbvMYs[Vy+d|Khz5,k4/.$');
define('LOGGED_IN_SALT',   '46hv]iK#*^uGW83#3.{#,$0u+?ZD1hJ;!GCCcRvKa(HUf}H&{0/`^>)mcPcjFnYe');
define('NONCE_SALT',       't^>gBd+J}ZH:i0;T-7UF`XbX+1)$H$;Px?r9Q$RPjJ>j3 ]yCDWk}6AsUtSy.&&L');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
