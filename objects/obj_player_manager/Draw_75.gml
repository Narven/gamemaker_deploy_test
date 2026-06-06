// Calculate how transparent the crosshair should be
var _alpha_paused = 1.0;

if (instance_exists(obj_effect_overlay))
{
	_alpha_paused = 1 - obj_effect_overlay.blocker_alpha;
}

var _alpha_paused_clamped = clamp(_alpha_paused, 0.0, 1.0);

// Draw the crosshair sprite at a position on the screen affected by the mouse position, recoil, and zoom
// Also scale it based on the current accuracy and zoom
var _aim_x = obj_input_manager.mouse_point[0] + fake_recoil[0] / (1 - obj_camera_manager.zoom * 0.4);
var _aim_y = obj_input_manager.mouse_point[1] + fake_recoil[1] / (1 - 0.4 * obj_camera_manager.zoom);

var _aim_scale = (1.25 + (2 * (accuracy - 1))) / (1 - 0.4 * obj_camera_manager.zoom);

var _aim_colour = merge_colour(c_white, c_red, clamp(last_hit, 0, 1));

draw_sprite_ext(spr_ui_aim_1, 0, 
	_aim_x, 
	_aim_y, 
	1, 
	1, 
	0, _aim_colour, ((1.25 / (1 - 0.4 * obj_camera_manager.zoom)) / _aim_scale ) * _alpha_paused);
	
draw_sprite_ext(spr_ui_aim_2, 0, 
	_aim_x, 
	_aim_y, 
	0.75, 
	0.75, 
	0, _aim_colour, _alpha_paused);

draw_sprite_ext(spr_ui_aim_3, 0, 
	_aim_x, 
	_aim_y, 
	_aim_scale * 0.5, 
	_aim_scale * 0.5, 
	0, c_white, _alpha_paused);