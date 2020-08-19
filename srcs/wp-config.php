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
 * @link https://codex.wordpress.org/Editing_wp-config.php
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
define('AUTH_KEY',         'kX;jEIv-SNkQ4MJ?Z({v^$j>e$/}eFzOg_&/7@3|Om~!+|M&=>i#Q4m1I6x|>2 ~');
define('SECURE_AUTH_KEY',  'T9:Eu yY--Yl.mc.QT#z@~U4!0 ,-YN+D_HVBh6#uJRQ)C.Ey084QwfUqshA:c-t');
define('LOGGED_IN_KEY',    '.+JGLQ -!j!ke5/C9TT+-*ihQ+$!+WGT7251z=T-3wFpq*IzWg2.<}Vca#+R~?kt');
define('NONCE_KEY',        'd%=boJQ&/zY(`Qz3Fj Z?+[gD-LO(0Sx,#N=4O/UZm#o{NC)tGx1-+%vav^p?;_A');
define('AUTH_SALT',        '|80kLa{8vltX&:X-l!D #^AC;43Dh>WOx)52fs.x[$Ti:y@#?D@SOAS+ef6N_!rX');
define('SECURE_AUTH_SALT', 'ollRy`ULZBbG*UBgo8xa>d?IYw@DF/CY!McvJ1?r;&eq}`~+Y|3E+n/c3z%EzZcj');
define('LOGGED_IN_SALT',   'T(:UX?_#rUbeME=+&MSIKD%qtu6BOrl+.o,@NrV6sBT# m9oyG&?8S3L|++~ld}|');
define('NONCE_SALT',       'Ial?`J4vVNe*E$|?_q1=Y>k!fA8LEY{&vXo]U5?pFdi}tT{}Pc_0(LNr]S~Z(+!2');

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
 * visit the Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', dirname( __FILE__ ) . '/' );
}

/** Sets up WordPress vars and included files. */
require_once( ABSPATH . 'wp-settings.php' );
