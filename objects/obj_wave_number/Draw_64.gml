// Draw the text for introducing a wave where this object is in the GUI
event_inherited();

draw_set_font(fnt_waves);

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed_colour(x, y, $"WAVE {obj_wave_manager.wave_num}", image_xscale, image_yscale, image_angle, image_blend, image_blend, image_blend, image_blend, image_alpha);

draw_set_valign(fa_top);
draw_set_halign(fa_left);