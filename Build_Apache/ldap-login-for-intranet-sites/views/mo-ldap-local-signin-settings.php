<?php
/**
 * Display Login Settings page.
 *
 * @package miniOrange_LDAP_AD_Integration
 * @subpackage views
 */

?>
<div class="mo_ldap_small_layout" style="margin-top:0px;">
	<form name="f" id="enable_login_form" method="post" action="">
		<?php wp_nonce_field( 'mo_ldap_local_enable' ); ?>
		<input type="hidden" name="option" value="mo_ldap_local_enable" />
		<h3 class="mo_ldap_left">Enable login using LDAP</h3>
		<div id="enable_ldap_login_bckgrnd">
			<input class="toggle_button" type="checkbox" id="enable_ldap_login" name="enable_ldap_login" value="1" <?php checked( esc_attr( strcasecmp( get_option( 'mo_ldap_local_enable_login' ), '1' ) === 0 ) ); ?> /><label class="toggle_button_label" for="enable_ldap_login"></label><span class="mo_ldap_local_toggle_label">Enable LDAP Login</span>
		</div>
		<p>Enabling LDAP login will protect your login page by your configured LDAP. <strong>Please check this only after you have successfully tested your configuration</strong> as the default WordPress login will stop working.</p>
	</form>
	<script>
		jQuery('#enable_ldap_login').change(function() {
			jQuery('#enable_login_form').submit();
		});
	</script>
	<form name="f" id="enable_admin_wp_login" method="post" action="">
		<?php wp_nonce_field( 'mo_ldap_local_enable_admin_wp_login' ); ?>
		<input type="hidden" name="option" value="mo_ldap_local_enable_admin_wp_login" />
		<?php
		$enable_both_login = get_option( 'mo_ldap_local_enable_login' );
		if ( strcasecmp( $enable_both_login, '1' ) === 0 ) {
			?>
			<input class="toggle_button" type="checkbox" id="mo_ldap_local_enable_admin_wp_login" name="mo_ldap_local_enable_admin_wp_login" value="1" <?php checked( esc_attr( strcasecmp( get_option( 'mo_ldap_local_enable_admin_wp_login' ), '1' ) === 0 ) ); ?> /><label class="toggle_button_label" for="mo_ldap_local_enable_admin_wp_login"></label><span class="mo_ldap_local_toggle_label">Authenticate Administrators from both LDAP and WordPress</span><br>
		<?php } ?>
	</form>
	<br>
	<form name="f" id="enable_register_user_form" method="post" action="">
		<?php wp_nonce_field( 'mo_ldap_local_register_user' ); ?>
		<input type="hidden" name="option" value="mo_ldap_local_register_user" />
		<input class="toggle_button" type="checkbox" id="mo_ldap_local_register_user" name="mo_ldap_local_register_user" value="1" <?php checked( esc_attr( strcasecmp( get_option( 'mo_ldap_local_register_user' ), '1' ) === 0 ) ); ?> /><label class="toggle_button_label" for="mo_ldap_local_register_user"></label><span class="mo_ldap_local_toggle_label">Enable Auto Registering users if they do not exist in WordPress</span>
	</form>
	<div id="miniorange-fallback-login" style="position:relative;background:white; line-height: 5;border-radius: 10px;">
		<input class="toggle_button" type="checkbox" id="" name="" disabled /><label class="toggle_button_label" for=""></label><span class="mo_ldap_local_toggle_label">Authenticate WP Users from both LDAP and WordPress <span style="color:#008000;"><strong> <em>( Supported in <a href="https://plugins.miniorange.com/wordpress-ldap-login-intranet-sites" target="_blank" rel="noopener">Premium Version</a> of the plugin. )</em></strong></span></span>
	</div>
	<div id="miniorange-protect-site">
		<input class="toggle_button" type="checkbox" id="" name="" disabled /><label class="toggle_button_label" for=""></label><span class="mo_ldap_local_toggle_label">Protect all website content by login <span style="color:#008000;"><strong> <em>( Supported in <a href="https://plugins.miniorange.com/wordpress-ldap-login-intranet-sites" target="_blank" rel="noopener">Premium Version</a> of the plugin. )</em></strong></span></span>
	</div>
	<br/>
</div>

<div class="mo_ldap_small_layout" style="margin-top:10px;">
	<h3>Restrict User Login by Role <span style="color: #008000;font-style: italic;font-size: 14px;margin-left: 5px;">[Available in <a href="https://plugins.miniorange.com/wordpress-ldap-login-intranet-sites" target="_blank" rel="noopener">Premium version</a> of the plugin.]</span></h3>
	<div id="mo_ldap_restrict_login_role">
		<form name="f" id="mo_ldap_save_restrict_login_by_role_form" method="post" action="">
			<input type="hidden" name="option" value="mo_ldap_save_restrict_login_by_role"/>
			<input disabled type="checkbox"  value="1" name="mo_ldap_local_restrict_user_by_role" id="mo_ldap_local_restrict_user_by_role" />Enable Restrict User Login by Role
			<br>
			<p style="color: green;"><em><strong>Note:</strong> User with the Administrator role will not be restricted while login.</em></p>
			<div id="panel1">
				<table class="mo_ldap_settings_table" id="mo_ldap_restrict_login_table" style="width:95%;table-layout: fixed;">
					<tr>
						<th></th>
						<th></th>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td>
							<font style="font-size:13px;font-weight:bold;">Restrict Role(s)</font>
						</td>
						<td>
							<div id="mo_ldap_local_restrict_login_dd" class="mo-ldap-restrict-login-role-dropdown" tabindex="100">
								<span class="mo_ldap_restrict_anchor">Select Role(s)</span>
								<ul class="mo_ldap_local_restrict_roles_list">
								<?php
								$roles = $utils::get_role_names();
								foreach ( $roles as $key => $wp_role ) {
									if ( strcasecmp( $key, 'administrator' ) === 0 ) {
										continue;
									}
									echo '<li><input disabled type="checkbox" id="mo_ldap_restrict_role[]" name="mo_ldap_restrict_role[]" value="' . esc_attr( $key ) . '"/>' . esc_html( $wp_role ) . '</li>';
								}
								?>
								</ul>
							</div>
						</td>
					</tr>
					<tr></tr>
					<tr></tr>
					<br>
					<tr>
						<td>
							<input disabled type="submit" value="Save Configuration" class="button button-primary button-large" >
						</td>
					</tr>
				</table>
			</div>
		</form>
	</div>
</div>

<script>
	var checkList = document.getElementById('mo_ldap_local_restrict_login_dd');
	checkList.getElementsByClassName('mo_ldap_restrict_anchor')[0].onclick = function(evt) {
		checkList.classList.toggle('visible');
	}
	jQuery('#mo_ldap_local_register_user').change(function() {
		jQuery('#enable_register_user_form').submit();
	});
	jQuery('#enable_fallback_login_form').change(function() {
		jQuery('#enable_fallback_login_form').submit();
	});
	jQuery('#enable_admin_wp_login').change(function() {
		jQuery('#enable_admin_wp_login').submit();
	});
</script>
