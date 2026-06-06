// Define the states enemies can be in
enum enemy_states { ENTERING, ACTIVE, DYING }

// Define the depth zones the enemies can be spawned in
enum enemy_zones { GROUND, AIR_CLOSE, AIR_FAR }

// Store how many enemies there are at any given moment and the maximum there can be
active_enemies = 0;

// Store some stats about how the current phase will function
max_enemies = 4;
enemies_per_spawn = 1;

// Create a countdown to the next enemy spawn
enemy_timer = 1;

// Define the furthest forward and back enemies can spawn
min_enemy_depth_ground = layer_get_depth("Character") + 4400;
max_enemy_depth_ground = min_enemy_depth_ground + 3000;

min_enemy_depth_air_close = layer_get_depth("Character") + 4000;
max_enemy_depth_air_close = min_enemy_depth_air_close + 3900;

min_enemy_depth_air_far = 4600;
air_far_depth_max = min_enemy_depth_air_far + 4000;

// Create a function so enemies can more easily find how far into their zone they are
function find_depth_mod(input_depth, enemy_zone)
{
	switch(enemy_zone)
	{
		case enemy_zones.GROUND:
			return (input_depth - min_enemy_depth_ground) / (max_enemy_depth_ground - min_enemy_depth_ground);
		case enemy_zones.AIR_CLOSE:
			return (input_depth - min_enemy_depth_air_close) / (max_enemy_depth_air_close - min_enemy_depth_air_close);
		case enemy_zones.AIR_FAR:
			return (input_depth -  min_enemy_depth_air_far) / (air_far_depth_max - min_enemy_depth_air_far);
	}
}

// Store all enemies and obstacles in order of their depths so they can be damaged in order of closest to furthest
all_enemies = [];

// Function to check whether a shot should have hit any of the enemies
function shoot_at(shot_x, shot_y, gun)
{
	// Find the inverse matrices of the camera matrices
	var _matrixViewProj = matrix_multiply(obj_camera_manager.view_mat, obj_camera_manager.proj_mat);
	var _matrixViewProjInv = matrix_inverse(_matrixViewProj);
	
	// Find where the shot would intersect with the floor
	var floor_point = screen_to_plane_3d(
	shot_x, 
	shot_y,
	[0, 1620, 4500],
	[0, -425, -27],
	_matrixViewProjInv);
	
	// Hold the depth as infinite if the vector doesn't hit the floor plane
	var floor_depth = ((floor_point == undefined) ? infinity : floor_point[2]);
	
	// Iterate through the enemies so the shot's trajectory can be checked against their position in the room
	// Stop after the closest enemy within the line has been found
	var first_found = false;
	for(var i = 0; i < array_length(all_enemies); i++)
	{
		// If something has already been shot, break the loop
		if(first_found)
		{
			break;
		}
		
		// Process with all enemies and obstacles
		with(all_enemies[i])
		{	
			// If the shot would hit the ground before it would hit this enemy/obstacle, trigger a ground hit
			// The floor only extends as far back as depth 4500 so if the ground plane intersects beyond that, stop checking against the ground
			if(depth > floor_depth && floor_depth <= 4500)
			{
				instance_create_depth(floor_point[0], floor_point[1], floor_point[2], obj_hitmarker, { owner: -1 });
				first_found = true;
				break;
			}
			
			// Find where the trajectory from the point clicked on screen into the room would cross the enemy/obstacles's depth
			var _point = screen_to_plane_3d(
			shot_x,
			shot_y,
			[0, 0, depth],
			[0, 0, -1],
			_matrixViewProjInv
			);
		
			// If the trajectory does actually cross that depth, check if it hit
			if (_point != undefined)
			{
				var _x = _point[0];
				var _y = _point[1];
				var _z = _point[2];
			
				// Do basic point-box collision detection
				if(collision_point(_x, _y, id, true, false))
				{
					// If the object hit is an obstacle, find what type and trigger appropriate sounds and hitmarkers
					if (object_is_ancestor(object_index, obj_obstacle_parent))
					{
						if (object_is_ancestor(object_index, obj_stage_obstacle_parent))
						{
							var _sfx = choose(
								obj_sound_manager.asset_sfx_bullet_hit_metal_1,
								obj_sound_manager.asset_sfx_bullet_hit_metal_2,
								obj_sound_manager.asset_sfx_bullet_hit_metal_3
							);
							
							obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
						}
						else
						{
							var _sfx = choose(
								obj_sound_manager.asset_sfx_bullet_hit_concrete_1,
								obj_sound_manager.asset_sfx_bullet_hit_concrete_2,
								obj_sound_manager.asset_sfx_bullet_hit_concrete_3
							);
							
							obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
						}
						
						instance_create_depth(_x, _y, depth - 1, obj_hitmarker, { owner_type: object_index });
						first_found = true;
					}
					else // Otherwise, the shot hits an enemy
					{
						// Find how much damage the shot should do
						// Each gun has a close and far falloff bound as well as how much falloff affects it
						// Find the percentage of the way between the two bounds the enemy is in terms of depth and use that as the reference point
						// Make the damage taken 1 * the gun's damage at the close bound, and the gun's minimum damage at the far bound
						var damage_mult = 1;
						if(depth >= obj_enemy_manager.min_enemy_depth_ground + gun.falloff_close)
						{
							var falloff_amount = (depth - (obj_enemy_manager.min_enemy_depth_ground + gun.falloff_close))/(gun.falloff_far - gun.falloff_close);
							falloff_amount = min(1, falloff_amount);
							damage_mult = gun.falloff_end_percent + (1 - gun.falloff_end_percent) * (1 - falloff_amount);
						}
						
						// Make the enemy take that much damage
						take_damage(gun.damage * damage_mult, false);
						
						// Trigger a sound effect
						var _sfx = choose(
							obj_sound_manager.asset_sfx_bullet_enemy_hit_1,
							obj_sound_manager.asset_sfx_bullet_enemy_hit_2,
							obj_sound_manager.asset_sfx_bullet_enemy_hit_3
						);
							
						obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
						
						// Create smoke from where the enemy was hit
						var _smoke_vfx = instance_create_depth(x, y, depth + 1, obj_particle_manager);
						var _smoke_layer = layer_create(depth + 1, string(_smoke_vfx.id) + string(current_time));
						_smoke_vfx.create_ps(ps_enemy_hit, _smoke_layer, -1, true, false);
						_smoke_vfx.is_layer_cleaned = true;
					
						// Also create a hitmarker at the hit point to show where the enemy was hit
						instance_create_depth(_x, _y, depth - 1, obj_hitmarker, { owner_type: object_index });
						first_found = true;
						
						// Set the player manager's "last hit" variable to 1 so the vignette changes colour
						obj_player_manager.last_hit = 1.0;
					}
				}
			}
		}
	}
}

function would_shoot_enemy(shot_x, shot_y)
{
	// Find the inverse matrices of the camera matrices
	var _matrixViewProj = matrix_multiply(obj_camera_manager.view_mat, obj_camera_manager.proj_mat);
	var _matrixViewProjInv = matrix_inverse(_matrixViewProj);
	
	// Find where the shot would intersect with the floor
	var floor_point = screen_to_plane_3d(
	shot_x, 
	shot_y,
	[0, 1620, 4500],
	[0, -425, -27],
	_matrixViewProjInv);
	
	// Hold the depth as infinite if the vector doesn't hit the floor plane
	var floor_depth = ((floor_point == undefined) ? infinity : floor_point[2]);
	
	// Iterate through the enemies so the shot's trajectory can be checked against their position in the room
	for(var i = 0; i < array_length(all_enemies); i++)
	{
		// Process with all enemies and obstacles
		with(all_enemies[i])
		{	
			// If the shot would hit the ground before it would hit this enemy/obstacle, trigger a ground hit
			// The floor only extends as far back as depth 4500 so if the ground plane intersects beyond that, stop checking against the ground
			if(depth > floor_depth && floor_depth <= 4500)
			{
				return false;
			}
			
			// Find where the trajectory from the point clicked on screen into the room would cross the enemy/obstacles's depth
			var _point = screen_to_plane_3d(
			shot_x,
			shot_y,
			[0, 0, depth],
			[0, 0, -1],
			_matrixViewProjInv
			);
		
			// If the trajectory does actually cross that depth, check if it hit
			if (_point != undefined)
			{
				var _x = _point[0];
				var _y = _point[1];
				var _z = _point[2];
			
				// Do basic point-box collision detection
				if(collision_point(_x, _y, id, true, false))
				{
					// If the object hit is an obstacle, find what type and trigger appropriate sounds and hitmarkers
					if (object_is_ancestor(object_index, obj_obstacle_parent))
					{
						return false;
					}
					else // Otherwise, the shot hits an enemy
					{
						return true;
					}
				}
			}
		}
	}
}

// Function to spawn an enemy
function spawn_enemy(enemy_types = undefined)
{
	// Flag whether the caller hasn't set any specific enemy types to spawn
	var set_enemy = (enemy_types != undefined);
	
	// Only try to spawn an enemy 10 times per call so the game can't hang trying to spawn when there's no space
	var tries = 0;
	while(tries < 10)
	{
		// Choose a specific enemy type to try to spawn, either completely randomly or from a list specified by the function caller
		var enemy_type = undefined;
		if(set_enemy) 
		{
			var rand = irandom(array_length(enemy_types) - 1);
			enemy_type = enemy_types[rand];
		}
		else
		{
			enemy_type = choose(obj_enemy_walking, obj_enemy_flying);
		}
		
		// Create space to hold a spawned enemy's index so it doesn't get destroyed by scope changes
		var new_enemy = undefined;
		
		// Try to spawn an enemy
		switch(enemy_type)
		{
			case obj_enemy_walking:
				// Find a position in the room to spawn the enemy that matches onto the ground
				var new_pos_depth = random_range(min_enemy_depth_ground, max_enemy_depth_ground);
				var floor_depth_mod = ((layer_get_depth("Character") + 8500) - new_pos_depth) / 8500;
				var new_depth_pos_mod = find_depth_mod(new_pos_depth, enemy_zones.GROUND);
				var new_pos_x =  room_width / 2 + random_range(-1500 - 1500 * new_depth_pos_mod, 1500 + 1500 * new_depth_pos_mod)
				var new_pos_y = room_height * 3/4 + room_height * 1/4 * floor_depth_mod;
				
				// Spawn the enemy
				new_enemy = instance_create_depth(new_pos_x, new_pos_y, new_pos_depth, enemy_type, {has_weak_spot : true, weak_spot_offset : [5, -150], zone_placement: enemy_zones.GROUND} );
				break;
							
			case obj_enemy_flying:
				// Choose a flying zone to spawn the enemy in
				var random_enemy_zone = choose(enemy_zones.AIR_CLOSE, enemy_zones.AIR_FAR);
				
				// Find a position in the room to spawn the enemy in that matches the specified air zone
				if(random_enemy_zone == enemy_zones.AIR_CLOSE)
				{
					var new_pos_depth = random_range(min_enemy_depth_air_close, max_enemy_depth_air_close);
					var new_depth_pos_mod = find_depth_mod(new_pos_depth, enemy_zones.AIR_CLOSE);
					var new_pos_x =  room_width / 2 - random_range(-room_width / 3, room_width / 3) * (2.2 - 1 * (1 - new_depth_pos_mod))
					var new_pos_y = 800 - 600 * new_depth_pos_mod - (700) * random(1);
					var new_zone = enemy_zones.AIR_CLOSE;
				}
				else
				{ 
					var new_pos_depth = random_range(min_enemy_depth_air_far, air_far_depth_max);
					var new_depth_pos_mod = find_depth_mod(new_pos_depth, enemy_zones.AIR_FAR);
					var new_pos_x =  room_width / 2 - random_range(-room_width / 3, room_width / 3) * (2.2 - 1 * (1 - new_depth_pos_mod))
					var new_pos_y = 600 - 300 * new_depth_pos_mod - (1300 + 100 * new_depth_pos_mod) * random(1);
					var new_zone = enemy_zones.AIR_FAR;
				}
				
				// Spawn the enemy
				new_enemy = instance_create_depth(new_pos_x, new_pos_y, new_pos_depth, enemy_type, {has_weak_spot : true, zone_placement: new_zone});
				break;
		}
		
		with(obj_enemy_parent)
		{
			if(id != new_enemy.id && abs(depth - new_enemy.depth) <= 50)
			{
				tries++;
				new_enemy.quick_destroy();
				break;
			}
		}
				
		if(instance_exists(new_enemy)) 
		{
			with(obj_obstacle_parent)
			{
				if(abs(depth - new_enemy.depth) <= 50)

				{
					tries++;
					new_enemy.quick_destroy();
					break;
				}
			}
			
			if(instance_exists(new_enemy)) 
			{
				break;
			}
		}
	}
}

// Function to see if there's a clear line between an enemy and the player so they don't try to shoot through
// each other or scene obstacles
function check_enemy_shot_clearance(enemy_id)
{
	// Find the exact point on the enemy the shot would originate from
	var x_shot_point = (enemy_id.x - enemy_id.image_xscale * sprite_get_xoffset(enemy_id.sprite_index) + enemy_id.sprite_width / 2);
	var y_shot_point = (enemy_id.y - enemy_id.image_yscale * sprite_get_yoffset(enemy_id.sprite_index) + enemy_id.sprite_height / 2)
	
	// Construct a vector between that point and the player character an make it uniform
	var enemy_shot_vec = [
		obj_player_manager.shoot_point[0] - x_shot_point,
		obj_player_manager.shoot_point[1] - y_shot_point,
		layer_get_depth("Character") - enemy_id.depth
	];
	enemy_shot_vec[0] /= abs(enemy_shot_vec[2]);
	enemy_shot_vec[1] /= abs(enemy_shot_vec[2]);
	enemy_shot_vec[2] = 1;
	
	// Start assuming the shot is valid and then try to disprove that
	var valid = true;
	
	// Iterate through everything in the all_enemies array except bulletsand if the line would intersect, mark the line as invalid
	for(var i = 0; i < array_length(all_enemies); i++)
	{
		with(all_enemies[i])
		{
			if((object_is_ancestor(object_index, obj_obstacle_parent) || object_is_ancestor(object_index, obj_enemy_parent)) && depth < enemy_id.depth)
			{
				var d_depth = enemy_id.depth - depth;
				if(collision_point(
					x_shot_point + enemy_shot_vec[0] * d_depth,
					y_shot_point + enemy_shot_vec[1] * d_depth,
					self, true, false))
				{
					valid = false;
				}
			}
		}
	}
	
	// Return the processed valid state
	return valid;
}

// Set up shader uniforms
// Set up the texture uvs for the enemy hp bars and their housings
var hp_uv_uniform = shader_get_uniform(sh_hp_bar, "bar_uvs");
var back_uv_uniform = shader_get_uniform(sh_hp_bar, "back_uvs");

var hp_uvs = sprite_get_uvs(spr_ui_enemy_hp_fill, 0);
var back_uvs = sprite_get_uvs(spr_ui_enemy_hp_back, 0);

shader_set(sh_hp_bar);
shader_set_uniform_f(hp_uv_uniform, hp_uvs[0], hp_uvs[2], hp_uvs[1], hp_uvs[3]);
shader_set_uniform_f(back_uv_uniform, back_uvs[0], back_uvs[2], back_uvs[1], back_uvs[3]);
shader_reset();