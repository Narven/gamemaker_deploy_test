// Scale according to the button's state as idle/hovered/pressed
image_xscale = current_button_scale;
image_yscale = current_button_scale;

// Draw the button
draw_self();

// Draw the button's label
draw_set_font(button_set_font);
draw_set_colour(current_colour_blend);
draw_set_alpha(image_alpha);
draw_set_halign(button_text_alignment);
draw_set_valign(fa_center);

draw_text_transformed(x, y + y_offset * current_text_scale, button_text, current_text_scale, current_text_scale, 0);