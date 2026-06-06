// If the button is hovered and the menu allows it to be active, register it as idle
if (current_button_state == BUTTON_STATE.HOVERED && obj_menu_manager.current_splash_state == active_state)
{
	target_button_scale = 1.0;
	target_text_scale = 1.0;
	
	current_colour = current_colour_blend;
	target_colour = c_silver;
	colour_mix_value = 0.0;

	current_button_state = BUTTON_STATE.IDLE;
}