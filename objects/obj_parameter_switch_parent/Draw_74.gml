// In the menu level, perform a normal draw
if (room != rm_level_city)
{
	exit;	
}

// Set the text draw settings for the switch label
draw_set_font(fnt_rationale_regular_48);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_set_alpha(image_alpha);
draw_set_colour(c_white);

// Draw the switch's label
draw_text_transformed(x - sprite_width * image_xscale * 2.15, y, switch_name, image_xscale * hover_scale, image_yscale * hover_scale, 0);

// Draw the switch itself with a toggle
draw_self();
draw_sprite_ext(spr_ui_button_toggle, 0, x + sprite_width * switch_value * 0.5, y, image_xscale, image_yscale, 0, c_white, image_alpha);

// Draw settings for the on/off text on the switch
draw_set_font(fnt_rationale_regular_32);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_set_alpha(0.8 * image_alpha);

// The two texts should be opposite colours
if (switch_value)
{
	draw_set_colour(c_grey);
}
else
{
	draw_set_colour(c_white);
}


draw_text_transformed(x + sprite_width * image_xscale * 0.25, y, "OFF", image_xscale, image_yscale, 0);

if (switch_value)
{
	draw_set_colour(c_white);
}
else
{
	draw_set_colour(c_grey);
}

draw_text_transformed(x + sprite_width * image_xscale * 0.75, y, "ON", image_xscale, image_yscale, 0);

