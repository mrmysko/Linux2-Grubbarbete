<?php
/**
 * Display Feedback form page.
 *
 * @package miniOrange_LDAP_AD_Integration
 * @subpackage views
 */

wp_enqueue_script( 'utils' );
wp_enqueue_style( 'mo_ldap_admin_plugins_page_style', MO_LDAP_LOCAL_INCLUDES . 'css/mo_ldap_local_plugin_style.min.css', array(), MO_LDAP_LOCAL_VERSION );
?>

</head>
<body>

<div id="ldapModal" class="mo_ldap_modal_feedback"  style="width:90%; margin:30px auto; text-align:center";>
	<div class="mo_ldap_modal_container_feedback" style="color:black"></div>
		<div class="mo_ldap_modal_content_feedback" style="width:50%;">
			<div class="mo_ldap_local_cross_button" onclick="getElementById('ldapModal').style.display = 'none'">+</div>
			<div class="mo_ldap_feedback_header mo_ldap_local_registration_heading">Your Feedback</div>
			<hr style="width:75%;">
			<div>
				Looking for more features? <a href="https://plugins.miniorange.com/wordpress-ldap-login-intranet-sites#get-premium-trial" class="mo_ldap_local_bold_label" rel="noopener" target="_blank">Get Full-Featured Trial</a>
			</div>
			<form name="f" method="post" action="" id="mo_ldap_feedback">
				<?php wp_nonce_field( 'mo_ldap_feedback' ); ?>
				<input type="hidden" name="option" value="mo_ldap_feedback"/>
				<div>
					<h4 style="text-align:center;">Please help us improve our plugin by giving us your opinion.</h4>
					<div id="smi_rate" class="mo_ldap_local_rating">
						<input type="radio" name="rate" id="angry" value="1"/>
						<label for="angry"><img class="sm" alt="Image not found" src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'angry.png' ); ?>" />
						</label>

						<input type="radio" name="rate" id="sad" value="2"/>
						<label for="sad"><img class="sm" alt="Image not found" src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'sad.png' ); ?>" />
						</label>


						<input type="radio" name="rate" id="neutral" value="3"/>
						<label for="neutral"><img class="sm" alt="Image not found" src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'normal.png' ); ?>" />
						</label>

						<input type="radio" name="rate" id="smile" value="4"/>
						<label for="smile">
							<img class="sm" alt="Image not found" src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'smile.png' ); ?>" />
						</label>

						<input type="radio" name="rate" id="happy" value="5" checked/>
						<label for="happy"><img class="sm" alt="Image not found" src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . 'happy.png' ); ?>" />
						</label>
					</div>
					<hr style="width:75%;">
					<?php
					$email = get_option( 'mo_ldap_local_admin_email' );
					if ( empty( $email ) ) {
						$user  = wp_get_current_user();
						$email = $user->user_email;
					}
					?>

					<div style="text-align:center;">
						<div class="mo_ldap_feedback_email_div">
							<label for="mail" class="mo_ldap_local_d_inline mo_ldap_local_bold_label">Email Address:</label>
							<input type="email" id="query_mail" name="query_mail" class="mo_ldap_pop_up_input_field mo_ldap_feedback_email_field" placeholder="your email address" required value="<?php echo esc_attr( $email ); ?>" readonly="readonly"/>

							<input type="radio" name="edit" id="edit" onclick="editName()" value=""/>
							<label for="edit"><img class="editable" alt="Image not found" src="<?php echo esc_url( MO_LDAP_LOCAL_IMAGES . '61456.png' ); ?>" />
							</label>

						</div>

						<br><br>
						<div class="mo_ldap_local_horizontal_flex_container">
							<input type="checkbox" id="mo_ldap_local_send_config" name="get_reply" class="mo_ldap_local_toggle_switch_hide" value="YES" checked />
							<label for="mo_ldap_local_send_config" class="mo_ldap_local_toggle_switch"></label>
							<label for="mo_ldap_local_send_config" class="mo_ldap_local_d_inline">
								I want to get in touch with your technical team for more assistance.
							</label>
						</div>
						<br>
						<strong>On submitting the feedback, your email address will be shared with the miniOrange team.</strong>
						<br><br>
						<div class="trial_page_input_description">
							<textarea style="width:60%; height: 100px;" cols="40" rows="5" id="query_feedback" name="query_feedback" placeholder="Tell us what happened!" class="mo_ldap_pop_up_input_field trial_page_input_email_text_tem"></textarea>
						</div>
					</div>
					<br>
					<div class="mo_ldap_modal-footer" style="text-align: center;margin-bottom: 2%">
						<input type="submit" class="mo_ldap_save_user_mapping" name="miniorange_ldap_feedback_submit" id="miniorange_ldap_feedback_submit"
							class="button button-primary-ldap button-large" value="Submit"/>
						<span width="30%">&nbsp;&nbsp;</span>
						<input type="button" name="miniorange_skip_feedback"
							class="mo_ldap_test_authentication_btn2 mo_ldap_wireframe_btn" style="font-weight:500;" value="Skip feedback & deactivate"
							onclick="document.getElementById('mo_ldap_feedback_form_close').submit();"/>
					</div>
				</div>

				<script>

					const INPUTS = document.querySelectorAll('#smi_rate input');
					INPUTS.forEach(el => el.addEventListener('click', (e) => updateValue(e)));


					function editName(){
						document.querySelector('#query_mail').removeAttribute('readonly');
						document.querySelector('#query_mail').focus();
						return false;
					}
					function updateValue(e) {
						document.querySelector('#outer').style.visibility="visible";
						var result = 'Thank you for appreciating our work';
						switch(e.target.value){
							case '1':	result = 'Not happy with our plugin ? Let us know what went wrong';
								break;
							case '2':	result = 'Found any issues? Let us know and we\'ll fix it ASAP';
								break;
							case '3':	result = 'Let us know if you need any help';
								break;
							case '4':	result = 'We\'re glad that you are happy with our plugin';
								break;
							case '5':	result = 'Thank you for appreciating our work';
								break;
						}
						document.querySelector('#result').innerHTML = result;

					}
				</script>
				<style>
					.editable{
						text-align:center;
						width:1em;
						height:1em;
					}
					.sm {
						text-align:center;
						width: 2vw;
						height: 2vw;
						padding: 1vw;
					}

					input[type=radio] {
						display: none;
					}

					.sm:hover {
						opacity:0.6;
						cursor: pointer;
					}

					.sm:active {
						opacity:0.4;
						cursor: pointer;
					}

					input[type=radio]:checked + label > .sm {
						border: 2px solid #21ecdc;
					}
				</style>



			</form>
			<form name="mo_ldap_feedback_form_close" method="post" action="" id="mo_ldap_feedback_form_close">
				<?php wp_nonce_field( 'mo_ldap_skip_feedback' ); ?>
				<input type="hidden" name="option" value="mo_ldap_skip_feedback"/>
			</form>

		</div>

	</div>

	<script>
		var active_plugins = document.getElementsByClassName('deactivate');
		for (i = 0; i<active_plugins.length;i++) {
			var plugin_deactivate_link = active_plugins.item(i).getElementsByTagName('a').item(0);
			var plugin_name = plugin_deactivate_link.href;
			if (plugin_name.includes('plugin=ldap-login-for-intranet-sites')) {
				jQuery(plugin_deactivate_link).click(function () {

				var mo_ldap_modal = document.getElementById('ldapModal');
				var span = document.getElementsByClassName("mo_ldap_close")[0];
				mo_ldap_modal.style.display = "block";
				window.onclick = function (event) {
					if (event.target == mo_ldap_modal) {
						mo_ldap_modal.style.display = "none";
					}
				}
				return false;
				});
				break;
			}
		}
	</script>
	</body>
