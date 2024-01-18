<?php
/**
 * Display plugin header.
 *
 * @package miniOrange_LDAP_AD_Integration
 * @subpackage views
 */

?>
<div class="mo_ldap_local_main_head" >
	<div class="mo_ldap_title_container">
		<div class="mo_ldap_local_title">
			<img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'logo.png' ); ?>" style="height:65px; width:65px;"><div class="mo_ldap_title_text"> LDAP/Active Directory Integration </div>
		</div>
	</div>
	<div class="mo_ldap_local_header_buttons_section">
		<div class="mo_ldap_local_column_flex_container mo_ldap_local_gap_20 mo_ldap_local_vertical_line">
			<div class="mo_ldap_local_rounded_rectangular_buttons mo_ldap_local_horizontal_flex_container" style="cursor:pointer;" data-id="mo_ldap_local_trial_box" onclick="mo_ldap_local_popup_card_clicked(this, '')" >Get Free Trial <span class="mo_ldap_free_trial">
			<svg width="19" height="21" viewBox="0 0 19 21" xmlns="http://www.w3.org/2000/svg">
				<path d="M3.24975 5C3.24975 3.80653 3.72386 2.66193 4.56777 1.81802C5.41168 0.974106 6.55628 0.5 7.74975 0.5C8.94322 0.5 10.0878 0.974106 10.9317 1.81802C11.7756 2.66193 12.2498 3.80653 12.2498 5C12.2498 5.19891 12.1707 5.38968 12.0301 5.53033C11.8894 5.67098 11.6987 5.75 11.4998 5.75C11.3008 5.75 11.1101 5.67098 10.9694 5.53033C10.8288 5.38968 10.7498 5.19891 10.7498 5C10.7498 4.20435 10.4337 3.44129 9.87107 2.87868C9.30846 2.31607 8.5454 2 7.74975 2C6.9541 2 6.19104 2.31607 5.62843 2.87868C5.06582 3.44129 4.74975 4.20435 4.74975 5C4.74975 5.19891 4.67073 5.38968 4.53008 5.53033C4.38943 5.67098 4.19866 5.75 3.99975 5.75C3.80084 5.75 3.61007 5.67098 3.46942 5.53033C3.32877 5.38968 3.24975 5.19891 3.24975 5ZM16.6776 10.25C15.8704 10.2875 15.2497 10.9831 15.2497 11.7903V12.4728C15.2524 12.6664 15.1816 12.8537 15.0517 12.9972C14.9217 13.1407 14.7423 13.2297 14.5494 13.2463C14.4468 13.2531 14.344 13.2387 14.2471 13.2041C14.1503 13.1694 14.0617 13.1153 13.9867 13.045C13.9117 12.9746 13.852 12.8896 13.8112 12.7952C13.7704 12.7008 13.7495 12.5991 13.7497 12.4963V10.2922C13.7497 9.485 13.1291 8.79219 12.3219 8.75187C12.1191 8.7421 11.9164 8.77361 11.7262 8.84449C11.5359 8.91536 11.362 9.02413 11.215 9.16421C11.068 9.30428 10.9509 9.47274 10.871 9.65938C10.791 9.84602 10.7498 10.047 10.7498 10.25V11.7247C10.7524 11.9182 10.6816 12.1056 10.5517 12.2491C10.4217 12.3926 10.2423 12.4816 10.0494 12.4981C9.94685 12.5049 9.84395 12.4906 9.74714 12.456C9.65034 12.4213 9.56168 12.3672 9.48669 12.2968C9.41169 12.2265 9.35196 12.1415 9.3112 12.0471C9.27044 11.9527 9.24952 11.8509 9.24975 11.7481V5.04219C9.24975 4.235 8.62912 3.54219 7.82194 3.50187C7.61912 3.4921 7.41644 3.52361 7.22616 3.59449C7.03588 3.66536 6.86197 3.77413 6.71498 3.91421C6.56798 4.05428 6.45095 4.22274 6.37098 4.40938C6.29101 4.59602 6.24977 4.79695 6.24975 5V16.2256C6.25203 16.407 6.19001 16.5833 6.0747 16.7234C5.95938 16.8634 5.79821 16.9581 5.61975 16.9906H5.6085C5.49662 17.0032 5.38354 16.9824 5.28345 16.9308C5.18337 16.8793 5.10076 16.7993 5.046 16.7009L3.07725 13.2847C2.67412 12.5853 1.78912 12.2937 1.071 12.6641C0.889536 12.7564 0.728758 12.8846 0.598458 13.041C0.468157 13.1975 0.371062 13.3788 0.313086 13.5739C0.25511 13.7691 0.237467 13.974 0.261231 14.1762C0.284994 14.3784 0.349668 14.5736 0.451312 14.75L3.35756 20.3797C3.42335 20.4918 3.51713 20.5848 3.62971 20.6497C3.74228 20.7146 3.8698 20.7492 3.99975 20.75H16.7497C16.8891 20.7501 17.0257 20.7114 17.1443 20.6382C17.2628 20.565 17.3586 20.4602 17.421 20.3356C17.4548 20.2681 18.2497 18.9237 18.2497 16.5247V11.75C18.25 11.5468 18.2089 11.3457 18.1291 11.1588C18.0492 10.9719 17.9322 10.8033 17.7852 10.663C17.6382 10.5227 17.4642 10.4138 17.2738 10.3428C17.0834 10.2718 16.8805 10.2402 16.6776 10.25Z" class="change-fill-on-hover"/>
			</svg>

			</span></div>
			<a href="<?php echo esc_url( add_query_arg( array( 'tab' => 'pricing' ), htmlentities( $filtered_current_page_url ) ) ); ?>" class="mo_ldap_local_unset_link_affect mo_ldap_local_rounded_rectangular_buttons mo_ldap_local_horizontal_flex_container">Premium Pricing <span class="mo_ldap_free_trial"><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'pricing.svg' ); ?>" height="20px" width="20px"></span></a>
		</div>
		<div class="mo_ldap_local_help_links">
		<div><a href="<?php echo esc_url( add_query_arg( array( 'tab' => 'faqs' ), $request_uri ) ); ?>" class="mo_ldap_local_unset_link_affect">FAQs</a></div>
			<div class="mo_ldap_cursor_pointer" data-id="mo_ldap_local_custom_requirements_box" onclick="mo_ldap_local_popup_card_clicked(this, '')" >Custom Requirements?</div>
			<div id="mo_ldap_local_documentation_section" class="mo_ldap_position_relative">
				<div id="mo_ldap_local_documentation_dropdown" class="mo_ldap_local_horizontal_flex_container mo_ldap_local_content_start mo_ldap_cursor_pointer">
					<div>Documentation</div> 
					<svg id="mo_ldap_local_doc_dropdown" style="margin-left: 5%;" viewBox="0 0 448 512" height="15px" width="15px" fill="#fff" class="mo_ldap_local_reverse_rotate">
						<path d="M201.4 342.6c12.5 12.5 32.8 12.5 45.3 0l160-160c12.5-12.5 12.5-32.8 0-45.3s-32.8-12.5-45.3 0L224 274.7 86.6 137.4c-12.5-12.5-32.8-12.5-45.3 0s-12.5 32.8 0 45.3l160 160z"/>
					</svg>
				</div>
				<div id="mo_ldap_local_absolute_documentation_box">
					<div class="mo_ldap_local_documentation_box">
						<div><a href="https://plugins.miniorange.com/step-by-step-guide-for-wordpress-ldap-login-plugin" target="_blank" class="mo_ldap_local_unset_link_affect"><span><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'doc.svg' ); ?>" height="20px" width="20px"></span><div>Setup LDAP/AD Plugin</div></a></div>
						<div><a href="https://www.youtube.com/watch?v=5DUGgP-Hf-k" target="_blank" class="mo_ldap_local_unset_link_affect"><span><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'video.svg' ); ?>" height="20px" width="20px"></span><div>LDAP/AD Plugin Setup</div></a></div>
						<div><a href="https://www.miniorange.com/guide-to-setup-ldaps-on-windows-server" target="_blank" class="mo_ldap_local_unset_link_affect"><span><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'doc.svg' ); ?>" height="20px" width="20px"></span><div>Setup LDAPS connection</div></a></div>
						<div><a href="https://youtu.be/r0pnB2d0QP8" target="_blank" class="mo_ldap_local_unset_link_affect"><span><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'video.svg' ); ?>" height="20px" width="20px"></span><div>Premium Plugin Features</div></a></div>
					</div>
				</div>
			</div>
		</div>
		<div class="mo_ldap_local_column_flex_container mo_ldap_local_gap_20">
			<a href="<?php echo esc_url( add_query_arg( array( 'tab' => 'account' ), $request_uri ) ); ?>" class="mo_ldap_local_my_account_styles mo_ldap_local_horizontal_flex_container mo_ldap_local_unset_link_affect"><span><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'account.svg' ); ?>" height="18px" width="18px"></span> My Account</a>
			<div class="mo_ldap_local_support_icons_container">
				<div class="mo_ldap_local_support_icon mo_ldap_local_horizontal_flex_container" data-id="mo_ldap_local_contact_us_box" onclick="mo_ldap_local_popup_card_clicked(this, '')" >
				Contact Us
				<span><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'mail.svg' ); ?>" height="18px" width="18px">
				</span></div>
				<div class="mo_ldap_local_setup_call_icon mo_ldap_local_horizontal_flex_container" data-id="mo_ldap_local_setup_call_box" onclick="mo_ldap_local_popup_card_clicked(this, '')" >Setup a call <span class="mo_ldap_local_call_icon_box"><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'phone.svg' ); ?>" height="15px" width="15px"></span></div>
			</div>
		</div>
	</div>
</div>
<?php

if ( ! $utils::is_extension_installed( 'ldap' ) ) {
	?>
		<div style="padding:20px;border-radius: 8px;margin: 10px;" class="notice notice-error is-dismissible">
			<span style="color:#FF0000">Warning: PHP LDAP extension is not installed or disabled.</span>
			<div id="help_ldap_warning_title" class="mo_ldap_title_panel">
				<p><a target="_blank" style="cursor: pointer;">Click here for instructions to enable it.</a></p>
			</div>
			<div hidden="" style="padding: 2px 2px 2px 12px" id="help_ldap_warning_desc" class="mo_ldap_help_desc">
			<ul>
				<li style="font-size: large; font-weight: bold">Step 1 </li>
				<li style="font-size: medium; font-weight: bold">Loaded configuration file : <?php echo esc_attr( php_ini_loaded_file() ); ?></li>
				<li style="list-style-type:square;margin-left:20px">Open php.ini file from above file path</strong></li><br/>
				<li style="font-size: large; font-weight: bold">Step 2</li>
				<li style="font-weight: bold;color: #C31111">For Windows users using Apache Server</li>
				<li style="list-style-type:square;margin-left:20px">Search for <strong>"extension=php_ldap.dll"</strong> in php.ini file. Uncomment this line, if not present then add this line in the file and save the file.</li>
				<li style="font-weight: bold;color: #C31111">For Windows users using IIS server</li>
				<li style="list-style-type:square;margin-left:20px">Search for <strong>"ExtensionList"</strong> in the php.ini file. Uncomment the <strong>"extension=php_ldap.dll"</strong> line, if not present then add this line in the file and save the file.</li>
				<li style="font-weight: bold;color: #C31111">For Linux users</li>
				<ul style="list-style-type:square;margin-left: 20px">
				<li style="margin-top: 5px">Install php ldap extension (If not installed yet)
					<ul style="list-style-type:disc;margin-left: 15px;margin-top: 5px">
						<li>For Ubuntu/Debian, the installation command would be <strong>sudo apt-get -y install php-ldap</strong></li>
						<li>For RHEL based systems, the command would be <strong>yum install php-ldap</strong></li></ul></li>
				<li>Search for <strong>"extension=php_ldap.so"</strong> in php.ini file. Uncomment this line, if not present then add this line in the file and save the file.</li></ul><br/>
				<li style="margin-top: 5px;font-size: large; font-weight: bold">Step 3</li>
				<li style="list-style-type:square;margin-left:20px">Restart your server. After that refresh the "LDAP/AD" plugin configuration page.</li>
				</ul>
				<strong>For any further queries, please contact us.</strong>
			</div>
		<p style="color:black">If your site is hosted on <strong>Shared Hosting</strong> platforms like Bluehost, DreamHost, SiteGround, Flywheel etc and you are not able to enable the extension then you can use our <a href="https://wordpress.org/plugins/miniorange-wp-ldap-login/" target="_blank" rel="noopener" style="cursor: pointer;">Active Directory/LDAP Integration for Cloud & Shared Hosting Platforms</a> plugin.</p>
		</div>
	<?php
}
if ( ! $utils::is_extension_installed( 'openssl' ) ) {
	?>
		<div class="notice notice-error is-dismissible">
		<p style="color:#FF0000">(Warning: <a target="_blank" rel="noopener" href="http://php.net/manual/en/openssl.installation.php">PHP OpenSSL extension</a> is not installed or disabled)</p>
		</div>
	<?php
}
?>

<div id="mo_ldap_local_custom_requirements_box" class="mo_ldap_local_popup_box mo_ldap_local_trial_popup mo_ldap_d_none">
	<div class="mo_ldap_local_cross_button" type="button" data-id="mo_ldap_local_custom_requirements_box" onclick="mo_ldap_local_popup_card_cancel_remove(this)">+</div>
	<div class="mo_ldap_local_popup_page">
		<div class="mo_ldap_local_popup_page_details">
			<div class="mo_ldap_local_popup_page_para mo_ldap_local_small_font">
				Looking for some other features <br> or having Custom Requirements?
				<br>
				<span><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'LargeArrow.svg' ); ?>" width="150px"></span>
			</div>

			<p style="padding: 5%;">Reach out to us with your requirements and we will get back to you at the earliest.</p>

			<div class="mo_ldap_local_popup_page_note">
				<div style="width: fit-content;border-bottom: 2px solid #FF9F38;margin: auto;padding-bottom: 5px; color:#000;">WE ARE HAPPY TO HEAR FROM YOU</div>
			</div>
		</div>

		<div class="mo_ldap_local_popup_page_input">
			<form name="mo_ldap_custom_requirement_form" method="post" id="mo_ldap_custom_requirement_form">
				<?php wp_nonce_field( 'mo_ldap_local_custom_requirements_req_nonce' ); ?>	
				<input type="hidden" name="option" value="mo_ldap_local_custom_requirements_req"/>
				<div class="trial_page_input_email">
					<label for="mo_ldap_local_custom_requirements_email" style="display:block;" class="mo_ldap_input_label_text">Email</label>
					<input name="mo_ldap_local_custom_requirements_email" id="mo_ldap_local_custom_requirements_email" type="email" placeholder="Enter your email" class="trial_page_input_email_text" required/>
				</div>
				<br>
				<div class="trial_page_input_email">
					<label for="mo_ldap_local_custom_requirements_phone" class="mo_ldap_input_label_text">Phone</label>
					<input name="mo_ldap_local_custom_requirements_phone" id="mo_ldap_local_custom_requirements_phone" style="margin-top: 6px;" type="tel" class="trial_page_input_email_text"/>
				</div>
				<br>
				<div class="trial_page_input_description">
					<p class="mo_ldap_input_label_text">Query</p>
					<textarea name="mo_ldap_local_description" cols="40" rows="5" placeholder="Write your Custom requirement here" class="trial_page_input_email_text trial_page_input_email_text_tem"></textarea>
				</div>
				<input type="submit" class="mo_ldap_save_user_mapping mo_ldap_save_user_mapping_temp" value="Request Feature">
			</form>
		</div>
	</div>
</div>

<div id="mo_ldap_local_trial_box" class="mo_ldap_local_popup_box mo_ldap_local_trial_popup mo_ldap_d_none">
	<div class="mo_ldap_local_cross_button" type="button" data-id="mo_ldap_local_trial_box" onclick="mo_ldap_local_popup_card_cancel_remove(this)">+</div>
	<div class="mo_ldap_local_popup_page">
		<div class="mo_ldap_local_popup_page_details">
			<div class="mo_ldap_local_popup_page_para">
				<strong>
					Get 5 Days <br> Full-Featured Trial
				</strong>
				<br>
				<span><img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'LargeArrow.svg' ); ?>" width="150px"></span>
			</div>

			<div class="mo_ldap_local_popup_page_note">
				<div style="text-align:center">
					<span style="color:#000; font-weight:600;">Watch Premium Features Video</span>
					<a target="_blank" rel="noopener" href="https://www.youtube.com/embed/r0pnB2d0QP8">
						<img class="mo_ldap_local_video_img" src="https://img.youtube.com/vi/r0pnB2d0QP8/hqdefault.jpg" alt="LDAP/AD Integration premium features">
					</a>
				</div>
			</div>
		</div>

		<div class="mo_ldap_local_popup_page_input">
			<form name="mo_ldap_trial_form" method="post" id="mo_ldap_trial_form">
				<?php wp_nonce_field( 'mo_ldap_local_trial_req_nonce' ); ?>	
				<input type="hidden" name="option" value="mo_ldap_local_trial_req"/>
				<div class="trial_page_input_email">
					<p class="mo_ldap_input_label_text">Email <span style="color:red;">*</span></p>
					<input name="mo_ldap_local_trial_email" type="email" placeholder="This email will be used to setup the trial" class="trial_page_input_email_text" value="<?php echo esc_attr( $admin_email ); ?>" required/>
				</div>
				<p class="mo_ldap_input_label_text">Request a trial for  <span style="color:red;">*</span></p>
				<input type="radio" id="singlesite" name="mo_ldap_local_site_type" value="Single Site" checked>
				<label for="singlesite" style="display:inline;">Singlesite</label> &nbsp;&nbsp;&nbsp;&nbsp;
				<input type="radio" id="multisite" name="mo_ldap_local_site_type" value="Multisite">
				<label for="multisite" style="display:inline;">Multisite</label>
				<br>
				<br>
				<select name="mo_ldap_licensing_plan" id="mo_ldap_licensing_plan" class="trial_page_input_select">
					<option value="" selected hidden>-- Select a license plan --</option>
					<option value="LDAP Essential Authentication Plan">LDAP Essential Authentication Plan</option>
					<option value="Kerberos/NTLM SSO Plan">Kerberos/NTLM SSO Plan</option>
					<option value="LDAP Advanced Authentication Plan">LDAP Advanced Authentication Plan</option>
					<option value="LDAP All-Inclusive Authentication Plan">LDAP All-Inclusive Authentication Plan</option>
				</select>
				<br>
				<br>
				<div class="trial_page_input_description">
					<p class="mo_ldap_input_label_text">Description</p>
					<textarea name="mo_ldap_local_description" cols="40" rows="5" placeholder="Need assistance? Write us about your requirements and we will setup a trial for you" class="trial_page_input_email_text trial_page_input_email_text_tem"></textarea>
				</div>
				<div class="trial_page_input_email">
					<p class="mo_ldap_input_label_text">Alternate Communication Email </p>
					<input name="mo_ldap_local_trial_alt_email" type="email" placeholder="Please Enter your alternate Email" class="trial_page_input_email_text"/>
				</div>
				<input type="submit" class="mo_ldap_save_user_mapping mo_ldap_save_user_mapping_temp" value="Send Request">
			</form>
		</div>
	</div>
</div>

<div id="mo_ldap_local_contact_us_box" class="mo_ldap_local_popup_box mo_ldap_local_contact_us_popup mo_ldap_d_none">
	<div class="mo_ldap_local_popup_div">
		<div class="mo_ldap_local_popup_title">
			Contact Us
		</div>
		<div class="mo_ldap_local_popup_description">
			<span>Need any help? We can help you with configuring LDAP configuration. Just send us a query so we can help you.</span>
		</div>
		<div>
			<form name="mo_ldap_local_contact_us_form" method="post" action="">
				<input type="hidden" name="option" value="mo_ldap_login_send_query"/>
				<?php wp_nonce_field( 'mo_ldap_login_send_query' ); ?>
				<div>
					<input type="email" class="mo_ldap_pop_up_input_field" id="mo_ldap_local_query_email" name="mo_ldap_local_query_email" value="<?php echo esc_attr( $admin_email ); ?>" placeholder="Enter your email" required>
					<div>
						<input type="text" style="height:38px;" class="mo_ldap_pop_up_input_field" name="mo_ldap_local_query_phone" id="mo_ldap_local_query_phone" value="<?php echo esc_attr( get_option( 'mo_ldap_local_admin_phone' ) ); ?>" placeholder="Enter your phone"/>
					</div>
					<div class="mo_ldap_local_horizontal_flex_container mo_ldap_local_send_config_toggle">
						<input type="checkbox" id="mo_ldap_local_send_config" name="mo_ldap_local_send_config" class="mo_ldap_local_toggle_switch_hide" onChange="mo_ldap_local_display_warning()"/>
						<label for="mo_ldap_local_send_config" class="mo_ldap_local_toggle_switch"></label>
						<label for="mo_ldap_local_send_config" class="mo_ldap_local_d_inline">
							Send LDAP Configuration
						</label>
					</div>
					<span id="mo_ldap_local_ldap_warning" style="color:red;display:none;"> * This will send the LDAP Configuration to our support team(No passwords are shared).</span>
					<textarea id="mo_ldap_local_query" name="mo_ldap_local_query" style="height:105px;border-radius:4px;width:100%;resize: none;" class="mo_ldap_pop_up_input_field" cols="52" rows="4"  placeholder="Write your query here" required ></textarea>
				</div>
				<input type="hidden" value="<?php echo esc_attr( get_option( 'mo_ldap_local_server_url' ) ? $utils::decrypt( get_option( 'mo_ldap_local_server_url' ) ) : '' ); ?>" >
				<div class="mo_ldap_local_horizontal_flex_container">
					<input type="submit" name="send_query" value="Submit Query" class="mo_ldap_save_user_mapping" />
					<button type="button" class="mo_ldap_cancel_button" data-id="mo_ldap_local_contact_us_box" onclick="mo_ldap_local_popup_card_cancel_remove(this)">Cancel</button>
				</div>
			</form>
		</div>
	</div>
</div>
<div id="mo_ldap_local_setup_call_box" class="mo_ldap_local_popup_box mo_ldap_local_contact_us_popup mo_ldap_d_none">
	<div class="mo_ldap_local_popup_div">
		<div class="mo_ldap_local_horizontal_flex_container">
			<div class="mo_ldap_local_popup_title">
				<img src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'setup_call.svg' ); ?>" height="100px">
			</div>
			<div class="mo_ldap_local_popup_description">
				<span>Setup a Call / Screen-share session with miniOrange Technical Team</span>
			</div>
		</div>
		<div>
			<form name="f" method="post" action="">
				<div>
					<div>
						<?php wp_nonce_field( 'mo_ldap_call_setup' ); ?>
						<input type="hidden" name="option" value="mo_ldap_call_setup"/>
						<label class="mo_ldap_input_label_text">Timezone<span style="color:red">*</span></label>
						<select class="mo_ldap_pop_up_input_field" name="mo_ldap_setup_call_timezone">
							<option value="" selected disabled>---------Select your timezone--------</option>
							<?php
							foreach ( $zones as $zone => $value ) {
								if ( strcasecmp( $value, 'Etc/GMT' ) === 0 ) {
									?>
									<option value="<?php echo esc_attr( $zone ) . ' ' . esc_attr( $value ); ?>" selected><?php echo esc_html( $zone ); ?></option>
									<?php
								} else {
									?>
									<option value="<?php echo esc_attr( $zone ) . ' ' . esc_attr( $value ); ?>"><?php echo esc_html( $zone ); ?></option>
									<?php
								}
							}
							?>
						</select>
					</div>
					<div>
						<label class="mo_ldap_input_label_text">Date<span style="color:red">*</span></label>
						<div class="mo_ldap_local_horizontal_flex_container">
							<input type="date" id="datepicker" placeholder="Select Meeting Date" autocomplete="off" name="mo_ldap_setup_call_date" required class="mo_ldap_pop_up_input_field">
							<input type="time" id="ldap-timepicker" value='now' placeholder="Select Meeting Time" autocomplete="off" name="mo_ldap_setup_call_time" required class="mo_ldap_pop_up_input_field">
						</div>
					</div>
					<input type="email" class="mo_ldap_pop_up_input_field" id="query_email" name="setup-call-email" value="<?php echo esc_attr( $admin_email ); ?>" placeholder="Enter your email" required>
					<textarea id="query" name="ldap-call-query" style="height:105px;border-radius:4px;width:100%;resize: none;" class="mo_ldap_pop_up_input_field" cols="52" rows="4"  placeholder="Write your query here" required ></textarea>
				</div>
				<div class="mo_ldap_local_horizontal_flex_container">
					<input type="submit" onclick="popupForm()" name="send_query" value="Setup a Call" class="mo_ldap_save_user_mapping" />
					<button type="button" class="mo_ldap_cancel_button" data-id="mo_ldap_local_setup_call_box" onclick="mo_ldap_local_popup_card_cancel_remove(this)">Cancel</button>
				</div>
			</form>
		</div>
	</div>
</div>

<div class="mo_ldap_local_overlay_back mo_ldap_d_none" id="mo_ldap_local_overlay"></div>
