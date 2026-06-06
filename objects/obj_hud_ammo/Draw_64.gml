// Find how far into the paused state the game is and draw proportionally transparent
var _alpha_paused = 1.0;

if (instance_exists(obj_effect_overlay))
{
	_alpha_paused = 1 - obj_effect_overlay.blocker_alpha;
}

var _alpha_paused_clamped = clamp(_alpha_paused, 0, 1.0);

draw_set_alpha(_alpha_paused_clamped);

image_alpha = _alpha_paused_clamped;

draw_self();

// Also draw some decorative housing around the box
draw_sprite(spr_ui_deco_wire, 0, room_width, room_height);

// Draw the ammo bar using the reload shader so it will draw partially transparent proportional to how full ammo is
draw_sprite(spr_ui_gun_housing, 0, x + 8, y + 30);

shader_set(sh_reload);
shader_set_uniform_f(mag_uniform, fake_mag_point);
draw_sprite(spr_ui_gun_fill, 0, x + 8, y + 30);
shader_reset();

// When the player's ammo is less than 10, show the "low ammo warning"
if(obj_player_manager.ammo_count < 10 && !obj_player_manager.is_reloading)
{
	is_warning = true;
	
	// The warning timer is on a 0.6 second loop so only show for half of it to make it flash and grab attention
	if(obj_game_manager.warning_flash_timer <= 0.3)
	{
		draw_sprite(spr_ui_warning_right, 0, x - 289, y - 194)
		if(surface_exists(warning_text))
			draw_surface(warning_text, x - 120 - obj_text_deformer.surface_width / 2, y - 102 - obj_text_deformer.surface_height / 2);
	}
}
else // Otherwise, no warning
{
	is_warning = false;
}

// Draw an ammo icon to show that the following text is ammunition
draw_sprite(spr_ui_ammo_icon, 0, x + 82, y - 30);

// Draw text stating how much ammo the player has left
// Only update the deformed text surface if the ammo has changed because it's costly on performance
if (obj_player_manager.ammo_count != check_ammo_count)
{
	check_ammo_count = obj_player_manager.ammo_count;
	
	if (surface_exists(ammo_text))
	{
		surface_free(ammo_text);
	}
	
	ammo_text = obj_text_deformer.create_text_skewed(obj_player_manager.ammo_count, -5, 1, fnt_ammo, true);
}

// Draw the text to the UI. Use the add blendmode so drawing the surface doesn't render fully transparent
if(surface_exists(ammo_text))
{
	gpu_set_blendmode(bm_add);
	draw_surface_ext(ammo_text, x + 181 - obj_text_deformer.surface_width/2, y - 29 - obj_text_deformer.surface_height/2, 1, 1, 0, c_aqua, _alpha_paused_clamped);
	gpu_set_blendmode(bm_normal);
}

// Reset draw alpha
draw_set_alpha(1.0);