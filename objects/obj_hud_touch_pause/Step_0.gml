if (position_meeting(get_mouse_x_real(), get_mouse_y_real(), self))
{
	if (current_button_state == BUTTON_STATE.IDLE)
	{
		target_button_scale = 1.0;
		target_text_scale = 1.05;
	
		current_colour = current_colour_blend;
		target_colour = c_white;
		colour_mix_value = 0.0;
	
		current_button_state = BUTTON_STATE.HOVERED;
	}
}
else
{
	target_button_scale = 1.0;
	target_text_scale = 1.0;
	
	current_colour = current_colour_blend;
	target_colour = c_silver;
	colour_mix_value = 0.0;

	current_button_state = BUTTON_STATE.IDLE;
}

if (current_button_scale != target_button_scale)
{
	current_button_scale = lerp(current_button_scale, target_button_scale, button_scale_rate * global.timer_delta * 0.000001);	
}

if (colour_mix_value < 1.0)
{
	colour_mix_value += colour_mix_rate * global.timer_delta * 0.000001;
	colour_mix_value = min(colour_mix_value, 1.0);
	
	current_colour_blend = merge_colour(current_colour, target_colour, colour_mix_value);
}