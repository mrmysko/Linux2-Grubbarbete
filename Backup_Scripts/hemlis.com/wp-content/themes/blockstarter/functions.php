<?php
/**
 * Blockstarter functions and definitions
 *
 * @link https://developer.wordpress.org/themes/basics/theme-functions/
 *
 * @package Blockstarter
 */

function blockstarter_setup() {

	// Make theme available for translation.
	load_theme_textdomain( 'blockstarter', get_template_directory() . '/languages' );

	// Add theme support
	add_theme_support( 'automatic-feed-links' );
	add_theme_support( 'wp-block-styles' );
	add_theme_support( 'title-tag' );
	add_theme_support( 'post-thumbnails' );
	add_theme_support( 'editor-styles' );
	add_theme_support( 'html5', array( 'comment-form', 'comment-list' ) );
	add_theme_support( 'responsive-embeds' );
}
add_action( 'after_setup_theme', 'blockstarter_setup' );

/**
 * Enqueue scripts and styles
 */
function blockstarter_scripts() {
	$version = wp_get_theme( 'blockstarter' )->get( 'Version' );
	// Stylesheet
	wp_enqueue_style( 'blockstarter-styles', get_theme_file_uri( '/style.css' ), array(), $version );

	if ( is_rtl() ) {
		wp_enqueue_style( 'rtl-css', get_template_directory_uri() . '/assets/css/rtl.css', 'rtl_css' );
	}
}
add_action( 'wp_enqueue_scripts', 'blockstarter_scripts' );

function blockstarter_excerpt_length( $length ) {
	return 25;
}
add_filter( 'excerpt_length', 'blockstarter_excerpt_length' );

/** Add default theme logo if no logo is specified */
function blockstarter_get_custom_logo_callback( $html ) {
	if ( has_custom_logo() ) {
		return $html;
	} else {
		$logo = '<svg xmlns="http://www.w3.org/2000/svg" width="32" height="32" viewBox="0 0 135.467 135.467" fill="none"><path d="M68.352 56.003L6.616 31.309 68.352 6.615l61.736 24.694-28.768 11.507z" stroke="#262626" stroke-linejoin="round" stroke-width="13.229"/><path d="M9.073 99.25c-3.392-1.356-7.241.294-8.598 3.686s.293 7.241 3.685 8.598zm59.28 30.836l-2.456 6.142c1.577.631 3.336.631 4.912 0zm64.192-18.553c3.392-1.357 5.042-5.207 3.686-8.598s-5.207-5.042-8.598-3.686zM9.073 62.209c-3.392-1.356-7.241.294-8.598 3.686s.293 7.241 3.685 8.598zm59.28 30.836l-2.456 6.142c1.577.631 3.336.631 4.912 0zm64.192-18.553c3.392-1.357 5.042-5.207 3.686-8.598s-5.207-5.042-8.598-3.686zM4.16 111.534l61.736 24.694 4.912-12.284L9.073 99.25zm66.649 24.694l61.736-24.694-4.912-12.284-61.736 24.694zM4.16 74.492l61.736 24.694 4.912-12.284L9.073 62.209zm66.649 24.694l61.736-24.694-4.912-12.284-61.736 24.694z" fill="#262626"/></svg>';
		return '<a href="' . esc_attr( home_url() ) . '">' . $logo . '</a>';
	}
}

add_filter( 'get_custom_logo', 'blockstarter_get_custom_logo_callback' );

/**
 * Registers block patterns categories, and type.
 */

function blockstarter_register_block_patterns() {
	$block_pattern_categories = array(
		'blockstarter' => array( 'label' => esc_html__( 'Blockstarter', 'blockstarter' ) ),
	);

	$block_pattern_categories = apply_filters( 'blockstarter_block_pattern_categories', $block_pattern_categories );

	foreach ( $block_pattern_categories as $name => $properties ) {
		if ( ! WP_Block_Pattern_Categories_Registry::get_instance()->is_registered( $name ) ) {
			register_block_pattern_category( $name, $properties );
		}
	}
}
add_action( 'init', 'blockstarter_register_block_patterns', 9 );

/* Add custom body class based on the style variation */
function blockstarter_body_classes( $classes ) {
	$style_variation = wp_get_global_settings( array( 'custom', 'variation' ) );
	if ( 'default' !== $style_variation ) {
		$classes[] = 'variation-' . $style_variation;
	}
	return $classes;
}
add_filter( 'body_class', 'blockstarter_body_classes' );

/**
 * Add block style variations.
 */
function blockstarter_register_block_styles() {

	$block_styles = array(
		'core/query'            => array(
			'left-featured-image' => __( 'Left Featured Image', 'blockstarter' ),
		),
		'core/post-terms'       => array(
			'term-button' => __( 'Button Style', 'blockstarter' ),
		),
		'core/query-pagination' => array(
			'pagination-button' => __( 'Button Style', 'blockstarter' ),
		),
	);

	foreach ( $block_styles as $block => $styles ) {
		foreach ( $styles as $style_name => $style_label ) {
			register_block_style(
				$block,
				array(
					'name'  => $style_name,
					'label' => $style_label,
				)
			);
		}
	}
}
add_action( 'init', 'blockstarter_register_block_styles' );

/**
 * Load custom block styles only when the block is used.
 */
function blockstarter_enqueue_custom_block_styles() {

	// Scan our css folder to locate block styles.
	$files = glob( get_template_directory() . '/assets/css/*.css' );

	foreach ( $files as $file ) {

		// Get the filename and core block name.
		$filename   = basename( $file, '.css' );
		$block_name = str_replace( 'core-', 'core/', $filename );

		wp_enqueue_block_style(
			$block_name,
			array(
				'handle' => "blockstarter-block-{$filename}",
				'src'    => get_theme_file_uri( "assets/css/{$filename}.css" ),
				'path'   => get_theme_file_path( "assets/css/{$filename}.css" ),
			)
		);
	}
}
add_action( 'init', 'blockstarter_enqueue_custom_block_styles' );

/**
 * Display the admin notice.
 */
function blockstarter_admin_notice() {
	global $current_user;
	$user_id = $current_user->ID;

	if ( ! get_user_meta( $user_id, 'blockstarter_ignore_customizer_notice' ) ) {
		?>

		<div class="notice notice-info">
			<p>
				<?php esc_html_e( 'If you like the free version of Blockstarter theme, you are gonna love the Pro version!', 'blockstarter' ); ?> <a target="_blank" href="https://nasiothemes.com/themes/blockstarter"><?php esc_html_e( 'Compare plans', 'blockstarter' ); ?></a>
				<span style="float:right">
					<a href="?blockstarter_ignore_customizer_notice=0"><?php esc_html_e( 'Hide Notice', 'blockstarter' ); ?></a>
				</span>
			</p>
		</div>

		<?php
	}
}
add_action( 'admin_notices', 'blockstarter_admin_notice' );

/**
 * Dismiss the admin notice.
 */
function blockstarter_dismiss_admin_notice() {
	global $current_user;
	$user_id = $current_user->ID;
	/* If user clicks to ignore the notice, add that to their user meta */
	if ( isset( $_GET['blockstarter_ignore_customizer_notice'] ) && '0' === $_GET['blockstarter_ignore_customizer_notice'] ) {
		add_user_meta( $user_id, 'blockstarter_ignore_customizer_notice', 'true', true );
	}
}
add_action( 'admin_init', 'blockstarter_dismiss_admin_notice' );
