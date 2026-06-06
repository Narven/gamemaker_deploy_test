// Check if debug enabled
if (global.DB_show_elements)
{
	// Debug element boxes
	draw_set_color(c_aqua);
	
	draw_rectangle(x - 50, y - 50, x + 50, y + 50, true);
	draw_set_color(c_white);
}