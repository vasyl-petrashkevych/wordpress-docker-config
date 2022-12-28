<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link    https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */
//GET HOSTNAME INFO
$hostname = $_SERVER['SERVER_NAME'];
define( 'WP_ENV', strpos( $_SERVER['SERVER_NAME'], 'localhost' ) ? 'development' : 'production' );

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
switch (WP_ENV) {
	case 'development':
		define( 'DB_NAME', 'root' );
		define( 'DB_USER', 'root' );
		define( 'DB_PASSWORD', 'root' );
		define( 'DB_HOST', 'db_server' );
		define( 'WP_DEBUG', true );
		break;
	default:
		break;
}
/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY', 'tg3f5srqD_?(P@waG e%A#2s[t@.uqwhBdz-?XZe**f|2pl=4SX]eCS5!LPrM<41' );
define( 'SECURE_AUTH_KEY', 'W=O/6KHF)7bWQt^zfqaVIz+}-.~&wHE1/PS#sT`&.{uecAXigr|>o`(({u 6-$L-' );
define( 'LOGGED_IN_KEY', 'm``kO`Lyd%;i8z*_rKo<y|Y-bUL63F%&eQC+j<VKvvWmOiV-qfvgTm[iuxxjBKG5' );
define( 'NONCE_KEY', 'KBn~Hkq: c9K*h;[Wr6[%W$@Qyc@A8k$ZZH]Wh31*+:2u|qgKvwJz@|5a@QM !e*' );
define( 'AUTH_SALT', 'SVL5GE2/c{y*Vu?#xX2byc69$+4*I*<pT/BdFDlyWlQ?kqDYQVN>)WuA&Y<8nYTs' );
define( 'SECURE_AUTH_SALT', 'WZ-?U-/k/B#yJY%<q}}M*_*o0~Ffc/6F(0fFKE uQ9f0n:Q[F#]MG,V^1?MGV!|B' );
define( 'LOGGED_IN_SALT', '6{*M$FbDy>*NPV)iu*]J*89gj4LG F?KDSfs+=9uZ3?fK!|:O_#muetJO#MbY!ca' );
define( 'NONCE_SALT', 'eicmL*T/g# 8TV<{^0oxDmp#MjuBL[Ha b=5Xicp0BMbQW#cWh~+J ovt6WPHCVy' );

/**#@-*/

/**
 * WordPress database table prefix.
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

/* Add any custom values between this line and the "stop editing" line. */

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
