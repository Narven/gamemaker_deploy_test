// If in game, draw the sprite where this object is in the GUI and text stating that the game is paused
if (room == rm_level_city)
{
	draw_self();
	
	draw_set_font(fnt_rationale_regular_48);

	draw_set_halign(fa_left);
	draw_set_valign(fa_middle);
	
	draw_set_alpha(image_alpha);
	draw_set_colour(c_white);
	
	draw_text_transformed(x - sprite_width * image_xscale * 0.49, y - sprite_height * image_yscale * 0.46, "PAUSED", image_xscale, image_yscale, 0);
}