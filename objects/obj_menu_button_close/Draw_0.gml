// The button can also appear in the main menu so it does need a draw event
if (room != rm_level_city)
{
	image_xscale = current_button_scale;
	image_yscale = current_button_scale;
	
	draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * current_button_scale * current_text_scale, image_yscale * current_button_scale * current_text_scale, 0, c_white, image_alpha);
}