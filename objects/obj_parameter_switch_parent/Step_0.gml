// Lerp to the correct size accoring to whether the switch is hovered
if (hovered)
{
	hover_scale = lerp(hover_scale, 1.25, 0.05);	
}
else
{
	hover_scale = lerp(hover_scale, 1.0, 0.2);	
}

// If the button is pressed on the left side: turn it off. The right: turn it on.
if (pressed)
{
	var _calc_value = (get_mouse_x_real() - x) / sprite_width;
	
	if (_calc_value < 0.5)
	{
		switch_value = false;	
	}
	else
	{
		switch_value = true;	
	}
}