// Make sure the enemy isn't currently dying
if(curr_state != enemy_states.DYING)
{
	// Slowly make the enemy worth less over time to reward quick shooting
	score_worth -= min((score_worth - 50) / 10, 10) * global.timer_delta * 0.000001;
	
	// Handle enemy movement speeds.
	// Check if the enemy should be moving
	if(!idle)
	{
		// Find how far through its current animation phase the enemy is
		var anim_pos = 0;
		
		switch(sprite_index)
		{
			case current_animation.in:
				anim_pos = image_index / sprite_get_info(sprite_index).num_subimages;
				break;
			case current_animation.during:
				anim_pos = 1;
				break;
			case current_animation.out:
				anim_pos = 1 - image_index / sprite_get_info(sprite_index).num_subimages;
				break;
		}
		
		// Find what the animation position corresponds to in the acceleration curve and use that as a multiplier for move speed
		// Damaged enemies move slower
		switch(curr_move_dir)
		{
			case "Left":
				move_speed[0] = -animcurve_channel_evaluate(acceleration_curve, anim_pos) * max_move_speed;
				move_speed[0] *= is_damaged ? 0.75 : 1.5;
				break;
			case "Right":
				move_speed[0] = animcurve_channel_evaluate(acceleration_curve, anim_pos) * max_move_speed;
				move_speed[0] *= is_damaged ? 0.75 : 1.5;
				break;
			case "Up":
				move_speed[1] = -animcurve_channel_evaluate(acceleration_curve, anim_pos) * max_move_speed;
				move_speed[1] *= is_damaged ? 0.75 : 1.5;
				break;
			case "Down":
				move_speed[1] = animcurve_channel_evaluate(acceleration_curve, anim_pos) * max_move_speed;
				move_speed[1] *= is_damaged ? 0.75 : 1.5;
				break;
		}
	
		// Add the movement amount to the current move distance
		curr_move_dist += point_distance(0, 0, move_speed[0] * global.timer_delta * 0.000001, move_speed[1] * global.timer_delta * 0.000001);
	
		// If the current move distance is greater than the desired move distance, trigger an animation change back to idle
		if(curr_move_dist >= end_move_dist)
		{
			trigger_animation_change = true;
		
			// If the enemy is currently entering the stage, reset its desired move distance and register as active
			if(curr_state == enemy_states.ENTERING)
			{
				end_move_dist = 400 + 400 * depth_mod;
				curr_state = enemy_states.ACTIVE;
			}
		}
	}
	else // Otherwise, don't move.
	{
		move_speed[0] = 0;
		move_speed[1] = 0;
		
		curr_move_dir = undefined;
	
		// Count down to the next movement
		move_timer -= global.timer_delta * 0.000001;

		// Of the next movement timer is below zero and an animation change hasn't been triggered yet, trigger one
		if(move_timer <= 0 && !trigger_animation_change)
		{
			next_move();
		}
	}
}

// Depending on the current state, do different things
switch(curr_state)
{
	// If the enemy is currently entering the scene don't do anything here as it's handled with movement
	case enemy_states.ENTERING:
		break;
	
	// If the enemy is currently active, have it try to shoot at the player
	case enemy_states.ACTIVE:
		hp_alpha = 1;
		shot_cooldown -= global.timer_delta * 0.000001;
		
		// Only let it shoot if it's not moving and has a clear shot at the player
		if (idle)
		{
			if(obj_enemy_manager.check_enemy_shot_clearance(id))
			{
				// If a shot has not been charged yet, create a charging particle effect
				if (!has_charged && shot_cooldown < 0.5)
				{
					var _pulse = instance_create_depth(x, y, depth - 1, obj_particle_manager);
					var _pulse_layer = layer_create(depth - 1, string(_pulse.id) + string(current_time));
					_pulse.create_ps(ps_red_pulse, _pulse_layer, self, true, false);
					_pulse.is_layer_cleaned = true;
					
					if (object_index == obj_enemy_walking)
					{
						_pulse.set_offset(5 * image_xscale, -150 * image_yscale);
					}
				
					// Also register that the shot has charged up now
					has_charged = true;
				
					// Also stop the enemy from moving by tying the movement timer to the shot cooldown
					shot_cooldown = 0.2;
					move_timer = max(move_timer, shot_cooldown);
				}
			
				// If the shot has been charged, fire it
				if (shot_cooldown <= 0)
				{
					// Register as uncharged for the next shot and reset the cooldown
					has_charged = false;
				    shot_cooldown = max_shot_cooldown * random_range(0.8, 1.2);
					
					// Create a bullet
				    instance_create_depth(x - image_xscale * sprite_get_xoffset(sprite_index) + sprite_width / 2, y - image_yscale * sprite_get_yoffset(sprite_index) + sprite_height / 2, depth - 1, obj_enemy_bullet, { damage: 2 + obj_wave_manager.wave_num * 3 });
				
					// Play a sound effect
				    var _sfx = choose(
				    obj_sound_manager.asset_sfx_enemy_weapon_1, 
				    obj_sound_manager.asset_sfx_enemy_weapon_2,
				    obj_sound_manager.asset_sfx_enemy_weapon_3,
				    obj_sound_manager.asset_sfx_enemy_weapon_4
				    );
    
				    obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
				}
			}
		}
		
		break;
	
	// If the enemy is dying, perform death behaviour
	case enemy_states.DYING:
		do_death_behaviour();
		break;
}

// Find how long it's been since the enemy was last damaged and make the health bar fade out if it's been 4 seconds
since_last_damage = since_last_damage + global.timer_delta * 0.000001;
hp_alpha = clamp(5 - since_last_damage, 0, 1);

// Lerp the end of the hp bar to where it should actually be for a more fluid transition
fake_hp = lerp(fake_hp, hp, 0.5);