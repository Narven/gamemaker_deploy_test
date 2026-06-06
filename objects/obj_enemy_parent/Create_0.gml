// Increment the number of enemies
obj_enemy_manager.active_enemies++;

// Set up the entering state
curr_state = enemy_states.ENTERING;

// Animation related variables
trigger_animation_change = false;
next_anim = undefined;
default_anim = global.enemy_animations.Flyer.Normal.Idle;
anim_tree = "Flyer";
current_animation = default_anim;
sprite_index = current_animation.during;
curr_anim_path = [anim_tree, "Normal", "Idle"];

// Hold how many points this enemy is worth when destroyed
score_worth = 200;

// Health related variables
is_damaged = false;
max_hp = 15;
hp = max_hp;

// Shooting related variables
has_charged = false;
shot_cooldown = 1.5;
max_shot_cooldown = 3;

// Health bar related variables
fake_hp = hp;
hp_alpha = 0;
hurt_time = 0;
since_last_damage = 5;

damage_number_point = [0, -300];

hp_point_uniform = shader_get_uniform(sh_hp_bar, "hp_point");
back_sampler = shader_get_sampler_index(sh_hp_bar, "background");

// Hold a modifier for how far into its zone an enemy is. Used for determining movement
depth_mod = obj_enemy_manager.find_depth_mod(depth, zone_placement);

// Movement related variables
move_pattern = ["Left", "Right"];
end_move_dist = 400 + 400 * depth_mod;
curr_move_dist = 0;

curr_move = irandom(array_length(move_pattern) - 1) - 1;
curr_move_dir = undefined;
next_move_dir = undefined;
idle = false;

move_cooldown = 1;
move_timer = move_cooldown;

move_speed = [0, 0];
max_move_speed = 600;

acceleration_curve = animcurve_get_channel(animcurve_get(ac_enemy_acceleration), "acc");

// Hold a space for a particle system for when the enemy is damaged
damaged_sparks = undefined;
spark_offset = [0, 0];

// Scale up the enemy to counteract the distance from the camera
image_xscale = 1.7;
image_yscale = image_xscale;

// Function to initiate a movement
function next_move()
{
	// Reset how far the enemy has moved
	curr_move_dist = 0;
	
	// Find the next direction the enemy should move
	curr_move++;
	if(curr_move >= array_length(move_pattern))
	{
		curr_move = 0;
	}
	
	next_move_dir = move_pattern[curr_move];
	next_anim = [anim_tree, is_damaged ? "Damage" : "Normal", "Move", next_move_dir];
	
	// Trigger an animation change to start the enemy moving
	trigger_animation_change = true;
}

// Function to instantly destroy the enemy without creating an explosion
function quick_destroy()
{
	instance_destroy();
}

// Function to make the enemy take damage and die
function take_damage(damage, is_from_weakpoint)
{
	// Stop the enemy from taking damage if it's already done so too recently
	if(hurt_time > 0) exit;

	// Reset the timer for the hp bar fading
	since_last_damage = 0;
	
	// Take the damage
	hp -= damage;
	
	// If it's from the weakpoint, reward the player by increasing the amount of points the enemy is worth
	if(is_from_weakpoint)
	{
		score_worth += 40;
	}
	
	// Sanitise the amount of damage the enemy took for damage numbers
	var _sanitised_damage = ceil(damage * 10) * 10;
		
	// Create a damage number
	if (global.damage_ui)
	{
		instance_create_depth(x + damage_number_point[0] * image_xscale, y + damage_number_point[1] * image_yscale, depth - 1, obj_damage_number, {damage_amount: _sanitised_damage, is_crit : is_from_weakpoint});
	}
	
	// If the damage would take its health down to zero, kill it
	if(hp <= 0)
	{
		hp = 0;
		curr_state = enemy_states.DYING;
	}
	else // Otherwise, make it flash white
	{
		hurt_time = 0.1;
	}
	
	// If the enemy isn't currently registering as damaged but its health is below 50%, make it register as damaged
	// Also create damage sparks particles and change the current animation to be its corresponding damaged version
	if(!is_damaged && hp <= 0.5 * max_hp)
	{
		// Register as damaged
		is_damaged = true;
			
		// Create damage sparks
		damaged_sparks = instance_create_depth(x + spark_offset[0], y + spark_offset[1], depth - 1, obj_particle_manager);
		var _spark_layer = layer_create(depth - 1, string(damaged_sparks.id) + string(current_time));
		damaged_sparks.create_ps(ps_enemy_damaged, _spark_layer, self, true, true);
		damaged_sparks.is_layer_cleaned = true;
		damaged_sparks.is_render_scaled = true;
		damaged_sparks.set_offset(spark_offset[0], spark_offset[1]);
		
		// Transfer over to the corresponding damaged animation
		var frame = image_index;
		curr_anim_path[1] = "Damage";
			
		var next_animation = find_animation(curr_anim_path, global.enemy_animations);
		next_animation ??= default_anim;
			
		var swapped = false;
		switch(sprite_index)
		{
			case current_animation.in:
				sprite_index = next_animation.in;
				if(sprite_index != undefined)
				{
					break;
				}
					
			case current_animation.during:
				sprite_index = next_animation.during;
				if(sprite_index != undefined)
				{
					break;
				}
					
			case current_animation.out:
				sprite_index = next_animation.out;
				if(sprite_index != undefined)
				{
					break;
				}
				
			default:
				sprite_index = default_anim.during;
		}
			
		current_animation = next_animation;
	}
}

// Function to kill the enemy in an explosion
function explode()
{
	// Add the amount of points the enemy is worth to the player's score
	obj_game_manager.points += round(score_worth);
	
	// Increment the number of enemies that have been destroyed in this wave
	obj_wave_manager.enemies_destroyed_this_wave++;
	
	// Create an explosion particle effect
	var _bang_layer = "MF" + string(current_time) + string(irandom(9999));
	layer_create(depth - 1, _bang_layer);
		
	var _bang = instance_create_layer(
		x,  
		y - 200, 
		_bang_layer,
		obj_particle_manager
	);
		
	_bang.is_layer_cleaned = true;
	
	if (depth > global.depth_cutoff_enemies)
	{
		_bang.create_ps(choose(ps_enemy_explosion, ps_enemy_explosion, ps_enemy_explosion_huge), _bang_layer, -1, true, false);
	}
	else
	{
		_bang.create_ps(ps_enemy_explosion_up_close, _bang_layer, -1, true, false);
	}
	
	// Destroy the enemy
	instance_destroy();
}

// Default death behaviour is to just explode and destroy. Overwrite in children for different death behaviours/animations
function do_death_behaviour()
{
	var _sfx = choose(
	obj_sound_manager.asset_sfx_enemy_defeated_ground_1, 
	obj_sound_manager.asset_sfx_enemy_defeated_ground_2,
	obj_sound_manager.asset_sfx_enemy_defeated_ground_3
	);
	
	obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
	
	explode();
}