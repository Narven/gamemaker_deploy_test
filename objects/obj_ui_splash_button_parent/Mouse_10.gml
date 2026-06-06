// If the button is ONLY hovered and the menu allows it to be active, play a sound and register it as hovered
if (current_button_state == BUTTON_STATE.IDLE && !mouse_check_button(mb_left) && obj_menu_manager.current_splash_state == active_state)
{
	target_button_scale = 1.0;
	target_text_scale = 1.05;
	
	current_colour = current_colour_blend;
	target_colour = c_white;
	colour_mix_value = 0.0;
	
	audio_play_sound(obj_sound_manager.asset_ui_hover, 50, false, obj_sound_manager.ui_level, 0.05);
	
	current_button_state = BUTTON_STATE.HOVERED;
}