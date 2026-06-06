// Find the changeable shader uniforms in the reload shader
mag_uniform = shader_get_uniform(sh_reload, "mag_percentage");
alpha_uniform = shader_get_uniform(sh_reload, "alpha_multi");

// Also find the uniform for the sprite's uvs in the shader
var uv_uniform = shader_get_uniform(sh_reload, "sprite_uvs");

// Find the gun sprite's uvs and pass them to the shader
var uvs = sprite_get_uvs(spr_ui_gun_fill, 0);
shader_set(sh_reload);
shader_set_uniform_f(uv_uniform, uvs[0], uvs[2], uvs[1], uvs[3]);
shader_reset();

// Calculate how full the gun should start
fake_mag_point = 1;
mag_point = obj_player_manager.ammo_count / obj_player_manager.ammo_max;

// Hold how much ammo the player has locally
fake_ammo_count = obj_player_manager.ammo_count;

// Also hold how much ammo the player had last frame for checking against
check_ammo_count = -1;

// Hold whether or not the warning is showing as well as the surface ID for the warning text
is_warning = false;
warning_text = obj_text_deformer.create_text_skewed("LOW AMMO", -5, 1, fnt_rationale_regular_30, true, 4);

// Hold the surface ID for the ammo text
ammo_text = obj_text_deformer.create_text_skewed(obj_player_manager.ammo_count, -5, 1, fnt_ammo, true, 1);