if (global.is_paused)
{
	exit;	
}

// Find the 3D vector between the character's position and this bullet
// Find how long that vector is and then turn it into a unit vector
var char_depth = layer_get_depth("Character");

var dist = point_distance_3d(x, y, depth, shoot_target[0], shoot_target[1], char_depth);

if(depth <= char_depth)
{
	dist *= -1;
}

// If the bullet has yet to cross the character threshold, make the distance a bit shorter
// Otherwise, make it a bit longer (as it should be moving away now)
dist -= (move_speed * (1.25 - 0.5 * damage/max_damage)) * (1 / 60);

// Move the bullet in 3D space by the unit vector multiplied by the new distance
x = shoot_target[0] - move_vec[0] * dist;
y = shoot_target[1] - move_vec[1] * dist;

if (!depth_locked && dist != 0)
{
	depth = char_depth - (move_vec[2] * dist) / global.projectile_speed;
}

// If the bullet has now crossed the character threshold, check if it should have hit the player
// Also make it become more transparent until it vanishes and is destroyed
if (depth <= char_depth)
{
	if(!hit_checked)
	{
		hit_checked = true;
		
		if (is_on_target) // A bullet is only a threat if it was ever going to hit the player. Some just miss.
		{
			if (is_on_wall) // If it hit the wall, see if it damaged the player, then create an explosion and die
			{
				if (obj_player_manager.standing)
				{
					obj_player_manager.take_damage(damage * 0.1);
					obj_vignette_manager.hit_cooldown += 0.5 * 0.1;
				}
				
				var _bang_layer = string(id) + string(current_time);
				layer_create(layer_get_depth("Stage_Front") + 1, _bang_layer);
				var _bang = instance_create_layer(x, y, _bang_layer, obj_particle_manager);
				_bang.create_ps(ps_cover_hit, _bang_layer, -1, true, true);
				_bang.is_layer_cleaned = true;
				
				var _sfx = choose(
					obj_sound_manager.asset_sfx_enemy_projectile_1, 
					obj_sound_manager.asset_sfx_enemy_projectile_2,
					obj_sound_manager.asset_sfx_enemy_projectile_3
				);
	
				obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
				
				curr_state = enemy_states.DYING;
		
				if (bullet_effect != -1)
				{
					instance_destroy(bullet_effect);
					bullet_effect = -1;
				}
			}
			else // Otherwise, just see if the player would have taken damage
			{
				if (obj_player_manager.standing) // Make the player take damage if they were standing and then explode
				{
					obj_player_manager.take_damage(damage);
					obj_vignette_manager.hit_cooldown += 0.5;
				
					curr_state = enemy_states.DYING;
					
					var _sfx = choose(
						obj_sound_manager.asset_sfx_enemy_projectile_1, 
						obj_sound_manager.asset_sfx_enemy_projectile_2,
						obj_sound_manager.asset_sfx_enemy_projectile_3
					);
					
					obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
		
					if (bullet_effect != -1)
					{
						instance_destroy(bullet_effect);
						bullet_effect = -1;
					}
				}
				else // Otherwise make the bullet miss and continue on its path
				{	
					curr_state = enemy_states.DYING;
		
					if (bullet_effect != -1)
					{
						bullet_effect.fade_ps(0.15);
					}
				}
			}		
		}
		else
		{
			curr_state = enemy_states.DYING;
		
			if (bullet_effect != -1)
			{
				bullet_effect.fade_ps(0.15);
			}
		}
	}
	
	// Make the bullet more transparent as it moves further past the player
	image_alpha -= 2 * global.update_time;
	
	// If it becomes fully transparent, destroy it
	if(image_alpha <= 0)
	{
		instance_destroy();
	}
}

// Recolour and move the particle systems
if (bullet_effect != -1 && instance_exists(bullet_effect))
{
	part_system_colour(bullet_effect.particle_sys, c_white, image_alpha * 0.8);
	part_system_depth(bullet_effect.particle_sys, depth);
}