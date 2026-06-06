// Inherit the parent event
event_inherited();

// Find a starting position to move into the scene from. This is based on depth and classified in an enemy_zone
// Far air enemies can start above the screen or below the end of the floor
if(zone_placement == enemy_zones.AIR_FAR)
{
	if(irandom(1) == 1)
	{
		y = -1500 - 1000 * depth_mod;
		next_move_dir = "Down";
	}
	else
	{
		y = 2000;
		next_move_dir = "Up";
	}
}
else // Close air enemies can only start above the screen
{
	y = -600 - 800 * depth_mod;
	next_move_dir = "Down";
	
	instance_create_depth(x, y, depth + 1, obj_enemy_shadow, {owner: id});
}

// It should move until it reaches where it was spawned
end_move_dist = abs(ystart - y);

// Trigger an animation change so it starts moving
trigger_animation_change = true;
next_anim = [anim_tree, is_damaged ? "Damage" : "Normal", "Move", next_move_dir];

// Set the death function to make a sound effect and have the enemy explode
function do_death_behaviour()
{
	var _sfx = choose(
	obj_sound_manager.asset_sfx_enemy_defeated_fly_1, 
	obj_sound_manager.asset_sfx_enemy_defeated_fly_2,
	obj_sound_manager.asset_sfx_enemy_defeated_fly_3
	);
	
	obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
	
	explode();
}

// If the enemy was instantiated to have a weak spot, create one and link it to this enemy
if(has_weak_spot)
{
	weak_spot = instance_create_depth(x + weak_spot_offset[0] * image_xscale, y + weak_spot_offset[1] * image_yscale, depth - 1, obj_enemy_weak_point, {owner : id});
}

// Set an offset where damage numbers will come from
damage_number_point = [0, -150];