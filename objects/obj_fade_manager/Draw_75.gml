// Draw a black rectangle over the entire screen with transparency equal to the fade amount
draw_set_colour(c_black);
draw_set_alpha(fade_amount);
draw_rectangle(0, 0, display_get_gui_width(), display_get_gui_height(), false);
draw_set_colour(c_white);
draw_set_alpha(1);