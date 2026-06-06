// Create a click sound effect
var _click_vfx = instance_create_depth(get_mouse_x_real(), get_mouse_y_real(), depth - 1, obj_particle_manager);
_click_vfx.create_ps(ps_player_click, "Menu", -1, false, false);
_click_vfx.set_late_draw(true);
