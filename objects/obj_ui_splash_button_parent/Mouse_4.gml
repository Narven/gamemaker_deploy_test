// If the button is hovered and the menu allows it to be active, register it as pressed
if (obj_menu_manager.current_splash_state == active_state)
{
	target_button_scale = 0.9;
	target_text_scale = 0.9;

	current_colour = current_colour_blend;
	target_colour = c_silver;
	colour_mix_value = 0.0;

	current_button_state = BUTTON_STATE.PRESSED;
}