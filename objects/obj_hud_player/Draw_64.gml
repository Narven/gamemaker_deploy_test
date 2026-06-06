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
draw_sprite_ext(spr_ui_deco_wire, 0, 0, room_height, -1, 1, 0, c_white, _alpha_paused_clamped);

// Draw the health bar with scale equal to how full it should be
draw_sprite(spr_ui_hp_housing, 0, x - 174, y + 62);
draw_sprite_ext(spr_ui_hp_fill, 0, x - 174, y + 62, fake_hp/obj_player_manager.max_hp, 1, 0, c_white, _alpha_paused_clamped);

// Draw a player icon just above the hp bar
draw_sprite_ext(spr_ui_player_icon, 0, x - 174, y + 61, 0.85, 0.85, 0, c_white, _alpha_paused_clamped);

// When the player has less than 20% hp left, start warning them
if(obj_player_manager.hp < obj_player_manager.max_hp * 0.2)
{
	is_warning = true;
	
	// The warning timer is on a 0.6 second loop so only show for half of it to make it flash and grab attention
	if(obj_game_manager.warning_flash_timer <= 0.3)
	{
		draw_sprite(spr_ui_warning_left, 0, x - 295, y - 48)
		if(surface_exists(warning_text))
			draw_surface(warning_text, x - 168 - obj_text_deformer.surface_width/2, y - 53 - obj_text_deformer.surface_height/2);
	}
}
else // Otherwise, no warning
{
	is_warning = false;
}

// Update the player score text if it has changed since last turn
if(check_score != obj_game_manager.points)
{
	check_score = obj_game_manager.points;
	
	if(surface_exists(score_text))
	{
		surface_free(score_text);
	}
	
	score_text = obj_text_deformer.create_text_skewed(obj_game_manager.points, 5, 1, fnt_hp, true, 1);
}

// Draw the text to the UI. Use the add blendmode so drawing the surface doesn't render fully transparent
if(surface_exists(score_text))
{
	gpu_set_blendmode(bm_add);
	draw_surface_ext(score_text, x + 129 - obj_text_deformer.surface_width/2, y - 64 - obj_text_deformer.surface_height/2, 1, 1, 0, c_aqua, _alpha_paused_clamped);
	gpu_set_blendmode(bm_normal);
}

// Reset draw alpha
draw_set_alpha(1.0);