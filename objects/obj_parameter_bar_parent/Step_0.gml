// Lerp the scale higher if it is hovered and lower if it isn't
if (hovered)
{
	hover_scale = lerp(hover_scale, 1.25, 0.05);	
}
else
{
	hover_scale = lerp(hover_scale, 1.0, 0.2);	
}

// If anywhere on the bar is pressed, find how far through the bar the toggle should be based on the press position
if (pressed)
{
	bar_percent = (get_mouse_x_real() - x) / sprite_width;
	bar_percent = clamp(bar_percent, 0, 1);
}