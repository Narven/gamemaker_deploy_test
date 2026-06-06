// Draw the player cursor
var _alpha_paused = 1.0;

if (instance_exists(obj_effect_overlay))
{
	_alpha_paused = obj_effect_overlay.blocker_alpha;
}

var _alpha_paused_clamped = clamp(_alpha_paused, 0.0, 1.0);

draw_sprite_ext(spr_ui_player_cursor, 0, get_mouse_x_real(), get_mouse_y_real(), 1.0, 1.0, 30, c_white, _alpha_paused_clamped);