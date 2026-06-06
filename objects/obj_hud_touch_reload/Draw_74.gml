var _alpha_paused = 1.0;

if (instance_exists(obj_effect_overlay))
{
	_alpha_paused = 1 - obj_effect_overlay.blocker_alpha;
}

draw_sprite_ext(spr_mobile_reload_Button, image_index, x, y, image_xscale * current_button_scale, image_yscale * current_button_scale, 0, current_colour_blend, _alpha_paused);
draw_sprite_ext(sprite_index, image_index, x, y, image_xscale * current_button_scale, image_yscale * current_button_scale, 0, current_colour_blend, _alpha_paused);