// Create a particle effect for the bullet
var _bang_layer = "MF" + string(current_time) + string(irandom(9999));
layer_create(depth, _bang_layer);

bang = instance_create_layer(
	x,  
	y, 
	_bang_layer,
	obj_particle_manager
);

bang.is_layer_cleaned = true;

// Use a different particle effect based on the different things the bullet can hit
if (owner_type != -1)
{
	// Obstacles are metal, one of them sparks more
	if (object_is_ancestor(owner_type, obj_background_obstacle_parent) || object_is_ancestor(owner_type, obj_stage_obstacle_parent))
	{
		if (owner_type == obj_stage_obstacle_3)
		{
			bang.create_ps(ps_bg_spark_hit, _bang_layer, -1, true, false);
		}
		else
		{
			bang.create_ps(ps_bg_metal_hit, _bang_layer, -1, true, false);
		}
	}
	else // Otherwise, an enemy is hit, so use a particle effect that is alrge enough to be visible
	{
		if (depth > global.depth_cutoff_enemies)
		{
			bang.create_ps(ps_enemy_hit, _bang_layer, -1, true, false);
		}
		else
		{
			bang.create_ps(ps_enemy_explosion_small, _bang_layer, -1, true, false);
		}
	}
}
else // Otherwise, it hit the ground so use a particle effect that makes it look as such
{
	bang.create_ps(ps_ground_explosion, _bang_layer, -1, true, false);
}