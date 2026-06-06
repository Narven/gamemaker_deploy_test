// Create a particle effect surrounding the bullet
var _bang_layer = string(id) + string(current_time);
layer_create(depth - 1, _bang_layer);
var _bang = instance_create_layer(x, y, _bang_layer, obj_particle_manager);
_bang.create_ps(ps_electrical_missile_shooting, _bang_layer, -1, true, false);

// Also create a particle effect for the bullet itself
var _bullet_layer = string(id) + string(current_time);
layer_create(depth, _bullet_layer);
bullet_effect = instance_create_layer(x, y, _bullet_layer, obj_particle_manager);
bullet_effect.create_ps(ps_energy_missile, _bullet_layer, self, true, true);
bullet_effect.is_layer_cleaned = true;

// Set up a flag to determine when the bullet is no longer a threat
hit_checked = false;
depth_locked = false;

// Set the bullet's state as an active enemy so it can be shot
curr_state = enemy_states.ACTIVE;

// Hold the maximum amount of damage the  bullet can do
max_damage = damage;

// Store where the bullet will hit
shoot_target = [
	room_width / 2 + 70,
	1220
];

// Create a 20% chance for the bullet to completely miss
is_on_target = irandom(4) != 0;
is_on_wall = false;

// If the shot is not on target, move the target point upwards
if (!is_on_target)
{
	shoot_target[1] -= 200;	
}
else // Otherwise, generate a 75% chance for it to hit the wall (adjusting target appropriately)
{
	is_on_wall = irandom(3) != 0;
	
	if (is_on_wall)
	{
		shoot_target[1] += 200;	
	}
}

// Calculate the unit vector that the bullet will follow
original_x = x;
original_y = y;
original_depth = depth;

var char_depth = layer_get_depth("Character");
var dist = point_distance_3d(original_x, original_y, original_depth, shoot_target[0], shoot_target[1], char_depth);

move_vec = [shoot_target[0] - original_x, shoot_target[1] - original_y, char_depth - original_depth];
move_vec[0] /= dist;
move_vec[1] /= dist;
move_vec[2] /= dist;

// Function for the bullet to take damage. It only has arguments so it can be used in the same way as the regular enemies'
function take_damage(taken_damage, virtual_for_polymorphism)
{
	// Create an explosion particle effect
	var _bang_layer = string(id) + string(current_time);
	layer_create(depth - 1, _bang_layer);
		
	var _bang = instance_create_layer(x, y, _bang_layer, obj_particle_manager);
		
	_bang.is_layer_cleaned = true;
	
	if (depth > global.depth_cutoff)
	{
		_bang.create_ps(ps_electrical_missile_explosion, _bang_layer, -1, true, false);
	}
	else
	{
		_bang.create_ps(ps_electrical_missile_explosion_up_close, _bang_layer, -1, true, false);
	}
	
	// Destroy the bullet
	instance_destroy();
}