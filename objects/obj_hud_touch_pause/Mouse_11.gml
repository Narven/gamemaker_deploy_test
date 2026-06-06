if (current_button_state == BUTTON_STATE.HOVERED)
{
	target_button_scale = 1.0;
	
	current_colour = current_colour_blend;
	target_colour = c_silver;
	colour_mix_value = 0.0;

	current_button_state = BUTTON_STATE.IDLE;
}