// If the bar is instantiated in the game level, draw on the GUI insted
if (room == rm_level_city)
{
	exit;	
}

// Draw the bar's label
draw_set_font(fnt_rationale_regular_48);

draw_set_halign(fa_left);
draw_set_valign(fa_middle);

draw_set_alpha(image_alpha);
draw_set_colour(c_white);

draw_text_transformed(x - sprite_width * image_xscale * 0.385, y, bar_name, image_xscale * hover_scale, image_yscale * hover_scale, 0);

// Draw the actual bar
draw_self();
draw_sprite_ext(spr_ui_button_selector, 0, x + sprite_width * bar_percent, y, image_xscale, image_yscale, 0, c_white, image_alpha);