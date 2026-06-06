// If the game is paused, stop animating and exit the event.
// Otherwise animate as normal
if(global.is_paused)
{
	image_speed = 0;
	exit;
}
else
{
	image_speed = 1;
}

// Inherit the parent event
event_inherited();

// Ground enemies should walk left and right normally, but should match the ground plane when moving forward and back
// That means when they move "down" they move at a 30 degree angle towards the camera
x += move_speed[0] * global.timer_delta * 0.000001;
y += sin(degtorad(30)) * move_speed[1] * global.timer_delta * 0.000001;
depth -= 4 *cos(degtorad(30)) * move_speed[1] * global.timer_delta * 0.000001;

// Create step VFX
// Create new VFX when the sprite's frame matches certain counts
// Specific positioning of VFX is dependant on which sprite the enemy is currently using
// As well as if the enemy is damaged
if (!is_damaged)
{
	// If there is no VFX, check if a new one should be made
	if (!has_step)
	{
		switch (sprite_index)
		{
			case spr_enemy_walk_normal_back_full:
				
				switch (image_index)
				{
					case 0:
						
						var _fl_step = instance_create_depth(x + (-227 + 72) * image_xscale, y + (-278 + 307) * image_yscale, depth - 1, obj_particle_manager);
						var _fl_step_layer = layer_create(depth - 1, string(_fl_step.id) + string(current_time));
						_fl_step.create_ps(ps_enemy_walking_dust, _fl_step_layer, -1, true, false);
						_fl_step.is_layer_cleaned = true;
						
						var _br_step = instance_create_depth(x + (-227 + 410) * image_xscale, y + (-278 + 315) * image_yscale, depth + 1, obj_particle_manager);
						var _br_step_layer = layer_create(depth - 1, string(_br_step.id) + string(current_time));
						_br_step.create_ps(ps_enemy_walking_dust, _br_step_layer, -1, true, false);
						_br_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 10:
						
						var _bl_step = instance_create_depth(x + (-227 + 64) * image_xscale, y + (-278 + 268) * image_yscale, depth + 1, obj_particle_manager);
						var _bl_step_layer = layer_create(depth - 1, string(_bl_step.id) + string(current_time));
						_bl_step.create_ps(ps_enemy_walking_dust, _bl_step_layer, -1, true, false);
						_bl_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 15:
						
						var _fr_step = instance_create_depth(x + (-227 + 378) * image_xscale, y + (-278 + 310) * image_yscale, depth - 1, obj_particle_manager);
						var _fr_step_layer = layer_create(depth - 1, string(_fr_step.id) + string(current_time));
						_fr_step.create_ps(ps_enemy_walking_dust, _fr_step_layer, -1, true, false);
						_fr_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
				}
				
				break;
				
			case spr_enemy_walk_normal_front_full:
			
				switch (image_index)
				{
					case 0:
						
						var _fl_step = instance_create_depth(x + (-227 + 75) * image_xscale, y + (-278 + 308) * image_yscale, depth - 1, obj_particle_manager);
						var _fl_step_layer = layer_create(depth - 1, string(_fl_step.id) + string(current_time));
						_fl_step.create_ps(ps_enemy_walking_dust, _fl_step_layer, -1, true, false);
						_fl_step.is_layer_cleaned = true;
						
						var _br_step = instance_create_depth(x + (-227 + 408) * image_xscale, y + (-278 + 240) * image_yscale, depth + 1, obj_particle_manager);
						var _br_step_layer = layer_create(depth - 1, string(_br_step.id) + string(current_time));
						_br_step.create_ps(ps_enemy_walking_dust, _br_step_layer, -1, true, false);
						_br_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
					
					case 10:
						
						var _fr_step = instance_create_depth(x + (-227 + 379) * image_xscale, y + (-278 + 308) * image_yscale, depth - 1, obj_particle_manager);
						var _fr_step_layer = layer_create(depth - 1, string(_fr_step.id) + string(current_time));
						_fr_step.create_ps(ps_enemy_walking_dust, _fr_step_layer, -1, true, false);
						_fr_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 15:
						
						var _bl_step = instance_create_depth(x + (-227 + 63) * image_xscale, y + (-278 + 266) * image_yscale, depth + 1, obj_particle_manager);
						var _bl_step_layer = layer_create(depth - 1, string(_bl_step.id) + string(current_time));
						_bl_step.create_ps(ps_enemy_walking_dust, _bl_step_layer, -1, true, false);
						_bl_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
				}
				
				break;
				
			case spr_enemy_walk_normal_left_full:
			
				switch (image_index)
				{
					case 0:
						
						var _fl_step = instance_create_depth(x + (-227 + 7) * image_xscale, y + (-278 + 272) * image_yscale, depth - 1, obj_particle_manager);
						var _fl_step_layer = layer_create(depth - 1, string(_fl_step.id) + string(current_time));
						_fl_step.create_ps(ps_enemy_walking_dust, _fl_step_layer, -1, true, false);
						_fl_step.is_layer_cleaned = true;
						
						var _br_step = instance_create_depth(x + (-227 + 396) * image_xscale, y + (-278 + 224) * image_yscale, depth + 1, obj_particle_manager);
						var _br_step_layer = layer_create(depth - 1, string(_br_step.id) + string(current_time));
						_br_step.create_ps(ps_enemy_walking_dust, _br_step_layer, -1, true, false);
						_br_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
					
					case 10:
						
						var _fr_step = instance_create_depth(x + (-227 + 376) * image_xscale, y + (-278 + 270) * image_yscale, depth - 1, obj_particle_manager);
						var _fr_step_layer = layer_create(depth - 1, string(_fr_step.id) + string(current_time));
						_fr_step.create_ps(ps_enemy_walking_dust, _fr_step_layer, -1, true, false);
						_fr_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 13:
						
						var _bl_step = instance_create_depth(x + (-227 + 4) * image_xscale, y + (-278 + 229) * image_yscale, depth + 1, obj_particle_manager);
						var _bl_step_layer = layer_create(depth - 1, string(_bl_step.id) + string(current_time));
						_bl_step.create_ps(ps_enemy_walking_dust, _bl_step_layer, -1, true, false);
						_bl_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
				}
				
				break;
				
			case spr_enemy_walk_normal_right_full:
			
				switch (image_index)
				{
					case 0:
						
						var _fl_step = instance_create_depth(x + (-235 + 88) * image_xscale, y + (-278 + 269) * image_yscale, depth - 1, obj_particle_manager);
						var _fl_step_layer = layer_create(depth - 1, string(_fl_step.id) + string(current_time));
						_fl_step.create_ps(ps_enemy_walking_dust, _fl_step_layer, -1, true, false);
						_fl_step.is_layer_cleaned = true;
						
						var _br_step = instance_create_depth(x + (-235 + 453) * image_xscale, y + (-278 + 227) * image_yscale, depth + 1, obj_particle_manager);
						var _br_step_layer = layer_create(depth - 1, string(_br_step.id) + string(current_time));
						_br_step.create_ps(ps_enemy_walking_dust, _br_step_layer, -1, true, false);
						_br_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
					
					case 10:
						
						var _fr_step = instance_create_depth(x + (-235 + 468) * image_xscale, y + (-278 + 271) * image_yscale, depth - 1, obj_particle_manager);
						var _fr_step_layer = layer_create(depth - 1, string(_fr_step.id) + string(current_time));
						_fr_step.create_ps(ps_enemy_walking_dust, _fr_step_layer, -1, true, false);
						_fr_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 13:
						
						var _bl_step = instance_create_depth(x + (-235 + 75) * image_xscale, y + (-278 + 231) * image_yscale, depth + 1, obj_particle_manager);
						var _bl_step_layer = layer_create(depth - 1, string(_bl_step.id) + string(current_time));
						_bl_step.create_ps(ps_enemy_walking_dust, _bl_step_layer, -1, true, false);
						_bl_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
				}
				
				break;
		}
	}
	else
	{
		// If the image index has changed, reset the flag for checks
		if (image_index != prev_index)
		{
			has_step = false;	
		}
	}
}
else if (is_damaged)
{
	if (!has_step)
	{
		switch (sprite_index)
		{
			case spr_enemy_walk_damage_back_full:
				
				switch (image_index)
				{
					case 0:
						
						var _bl_step = instance_create_depth(x + (-229 + 5) * image_xscale, y + (-329 + 281) * image_yscale, depth + 1, obj_particle_manager);
						var _bl_step_layer = layer_create(depth - 1, string(_bl_step.id) + string(current_time));
						_bl_step.create_ps(ps_enemy_walking_dust, _bl_step_layer, -1, true, false);
						_bl_step.is_layer_cleaned = true;
						
						var _fr_step = instance_create_depth(x + (-229 + 449) * image_xscale, y + (-329 + 317) * image_yscale, depth - 1, obj_particle_manager);
						var _fr_step_layer = layer_create(depth - 1, string(_fr_step.id) + string(current_time));
						_fr_step.create_ps(ps_enemy_walking_dust, _fr_step_layer, -1, true, false);
						_fr_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 12:
						
						var _fl_step = instance_create_depth(x + (-229 + 3) * image_xscale, y + (-329 + 295) * image_yscale, depth - 1, obj_particle_manager);
						var _fl_step_layer = layer_create(depth - 1, string(_fl_step.id) + string(current_time));
						_fl_step.create_ps(ps_enemy_walking_dust, _fl_step_layer, -1, true, false);
						_fl_step.is_layer_cleaned = true;
						
						var _br_step = instance_create_depth(x + (-229 + 452) * image_xscale, y + (-329 + 274) * image_yscale, depth + 1, obj_particle_manager);
						var _br_step_layer = layer_create(depth - 1, string(_br_step.id) + string(current_time));
						_br_step.create_ps(ps_enemy_walking_dust, _br_step_layer, -1, true, false);
						_br_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
				}
				
				break;
				
			case spr_enemy_walk_damage_front_full:
			
				switch (image_index)
				{
					
						
					case 0:
						
						var _fl_step = instance_create_depth(x + (-228 + 74) * image_xscale, y + (-329 + 354) * image_yscale, depth - 1, obj_particle_manager);
						var _fl_step_layer = layer_create(depth - 1, string(_fl_step.id) + string(current_time));
						_fl_step.create_ps(ps_enemy_walking_dust, _fl_step_layer, -1, true, false);
						_fl_step.is_layer_cleaned = true;
						
						var _br_step = instance_create_depth(x + (-228 + 407) * image_xscale, y + (-329 + 292) * image_yscale, depth + 1, obj_particle_manager);
						var _br_step_layer = layer_create(depth - 1, string(_br_step.id) + string(current_time));
						_br_step.create_ps(ps_enemy_walking_dust, _br_step_layer, -1, true, false);
						_br_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 10:
						
						var _fr_step = instance_create_depth(x + (-228 + 378) * image_xscale, y + (-329 + 353) * image_yscale, depth - 1, obj_particle_manager);
						var _fr_step_layer = layer_create(depth - 1, string(_fr_step.id) + string(current_time));
						_fr_step.create_ps(ps_enemy_walking_dust, _fr_step_layer, -1, true, false);
						_fr_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 15:
						
						var _bl_step = instance_create_depth(x + (-228 + 60) * image_xscale, y + (-329 + 312) * image_yscale, depth + 1, obj_particle_manager);
						var _bl_step_layer = layer_create(depth - 1, string(_bl_step.id) + string(current_time));
						_bl_step.create_ps(ps_enemy_walking_dust, _bl_step_layer, -1, true, false);
						_bl_step.is_layer_cleaned = true;
					
						has_step = true;
					
						break;
				}
				
				break;
				
			case spr_enemy_walk_damage_left_full:
			
				switch (image_index)
				{
					case 0:
						
						var _fl_step = instance_create_depth(x + (-257 + 13) * image_xscale, y + (-336 + 305) * image_yscale, depth - 1, obj_particle_manager);
						var _fl_step_layer = layer_create(depth - 1, string(_fl_step.id) + string(current_time));
						_fl_step.create_ps(ps_enemy_walking_dust, _fl_step_layer, -1, true, false);
						_fl_step.is_layer_cleaned = true;
						
						var _br_step = instance_create_depth(x + (-257 + 411) * image_xscale, y + (-336 + 262) * image_yscale, depth + 1, obj_particle_manager);
						var _br_step_layer = layer_create(depth - 1, string(_br_step.id) + string(current_time));
						_br_step.create_ps(ps_enemy_walking_dust, _br_step_layer, -1, true, false);
						_br_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 10:
						
						var _fr_step = instance_create_depth(x + (-257 + 447) * image_xscale, y + (-336 + 300) * image_yscale, depth - 1, obj_particle_manager);
						var _fr_step_layer = layer_create(depth - 1, string(_fr_step.id) + string(current_time));
						_fr_step.create_ps(ps_enemy_walking_dust, _fr_step_layer, -1, true, false);
						_fr_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 13:
						
						var _bl_step = instance_create_depth(x + (-257 + 2) * image_xscale, y + (-336 + 262) * image_yscale, depth + 1, obj_particle_manager);
						var _bl_step_layer = layer_create(depth - 1, string(_bl_step.id) + string(current_time));
						_bl_step.create_ps(ps_enemy_walking_dust, _bl_step_layer, -1, true, false);
						_bl_step.is_layer_cleaned = true;
					
						has_step = true;
					
						break;
				}
				
				break;
				
			case spr_enemy_walk_damage_right_full:
			
				switch (image_index)
				{
					case 0:
						
						var _fl_step = instance_create_depth(x + (-234 + 90) * image_xscale, y + (-318 + 306) * image_yscale, depth - 1, obj_particle_manager);
						var _fl_step_layer = layer_create(depth - 1, string(_fl_step.id) + string(current_time));
						_fl_step.create_ps(ps_enemy_walking_dust, _fl_step_layer, -1, true, false);
						_fl_step.is_layer_cleaned = true;
						
						var _br_step = instance_create_depth(x + (-234 + 447) * image_xscale, y + (-318 + 259) * image_yscale, depth + 1, obj_particle_manager);
						var _br_step_layer = layer_create(depth - 1, string(_br_step.id) + string(current_time));
						_br_step.create_ps(ps_enemy_walking_dust, _br_step_layer, -1, true, false);
						_br_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 10:
						
						var _fr_step = instance_create_depth(x + (-234 + 465) * image_xscale, y + (-318 + 308) * image_yscale, depth - 1, obj_particle_manager);
						var _fr_step_layer = layer_create(depth - 1, string(_fr_step.id) + string(current_time));
						_fr_step.create_ps(ps_enemy_walking_dust, _fr_step_layer, -1, true, false);
						_fr_step.is_layer_cleaned = true;
						
						has_step = true;
					
						break;
						
					case 13:
						
						var _bl_step = instance_create_depth(x + (-234 + 74) * image_xscale, y + (-318 + 261) * image_yscale, depth + 1, obj_particle_manager);
						var _bl_step_layer = layer_create(depth - 1, string(_bl_step.id) + string(current_time));
						_bl_step.create_ps(ps_enemy_walking_dust, _bl_step_layer, -1, true, false);
						_bl_step.is_layer_cleaned = true;
					
						has_step = true;
					
						break;
				}
				
				break;
		}
	}
	else
	{
		if (image_index != prev_index)
		{
			has_step = false;	
		}
	}
}