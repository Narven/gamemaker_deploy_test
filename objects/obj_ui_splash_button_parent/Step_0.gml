// If the menu state does not match the one this button is active in, display as idle
if(obj_menu_manager.current_splash_state != active_state)
{
	target_button_scale = 1.0;
	target_text_scale = 1.0;
	
	current_colour = current_colour_blend;
	target_colour = c_silver;
	colour_mix_value = 0.0;

	current_button_state = BUTTON_STATE.IDLE;
}
else if (current_button_state == BUTTON_STATE.IDLE && position_meeting(get_mouse_x_real(), get_mouse_y_real(), self))
{
	target_button_scale = 1.0;
	target_text_scale = 1.05;
	
	current_colour = current_colour_blend;
	target_colour = c_white;
	colour_mix_value = 0.0;
	
	current_button_state = BUTTON_STATE.HOVERED;
}

// Lerp the scales towards their targets
if (current_button_scale != target_button_scale)
{
	current_button_scale = lerp(current_button_scale, target_button_scale, button_scale_rate * global.timer_delta * 0.000001);	
}

if (current_text_scale != target_text_scale)
{
	current_text_scale = lerp(current_text_scale, target_text_scale, text_scale_rate * global.timer_delta * 0.000001);	
}

// Move the button's colour closer to the target
if (colour_mix_value < 1.0)
{
	colour_mix_value += colour_mix_rate * global.timer_delta * 0.000001;
	colour_mix_value = min(colour_mix_value, 1.0);
	
	current_colour_blend = merge_colour(current_colour, target_colour, colour_mix_value);
}