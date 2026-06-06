if (room != rm_level_city)
{
	exit;	
}
	
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * current_button_scale, image_yscale * current_button_scale, 0, c_white, image_alpha);

draw_set_font(button_set_font);
draw_set_colour(c_white);
draw_set_alpha(image_alpha);
draw_set_halign(button_text_alignment);
draw_set_valign(fa_center);

draw_text_transformed(x, y + y_offset * current_text_scale, button_text, current_text_scale, current_text_scale, 0);