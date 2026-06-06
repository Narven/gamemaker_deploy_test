// Find the view projection matrix
var _matrixViewProj = matrix_multiply(obj_camera_manager.view_mat, obj_camera_manager.proj_mat);

// Find where on the screen the enemy will appear
var point = world_to_screen(x, y, depth, _matrixViewProj, false, room_width, room_height);

// Find a y offset based on the enemy's depth
var bar_depth_mod = (depth - obj_camera_manager.plane_near) / 4000;
var bar_y_offset = ((object_index == obj_enemy_flying) ? 150 : 250) * 2.1 / bar_depth_mod;

// If the game is paused, it should be transparent (and fade into transparency) 
var _alpha_paused = 1.0;

if (instance_exists(obj_effect_overlay))
{
	_alpha_paused = 1 - obj_effect_overlay.blocker_alpha;
}

var _alpha_paused_clamped = clamp(_alpha_paused, 0.0, 1.0);

// Draw the hp bar using the hp bar shader
shader_set(sh_hp_bar);
shader_set_uniform_f(hp_point_uniform, fake_hp / max_hp);
texture_set_stage(back_sampler, sprite_get_texture(spr_ui_enemy_hp_back, 0));
draw_sprite_ext(spr_ui_enemy_hp_fill, 0, point[0], point[1] - bar_y_offset, 1, 1, 0, c_white, min(_alpha_paused_clamped, hp_alpha));
shader_reset();