// Draw the gradients on the top and bottom of the screen
var _alpha_paused = 1.0;

if (instance_exists(obj_effect_overlay))
{
	_alpha_paused = obj_effect_overlay.blocker_alpha;
}

draw_sprite_ext(spr_gradient, 0, 0, 0, room_width, 4, 0, c_white, _alpha_paused);
draw_sprite_ext(spr_gradient, 0, room_width, room_height, room_width, 4, 180, c_grey, _alpha_paused);