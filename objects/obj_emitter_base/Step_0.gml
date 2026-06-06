// Checks for an owner
if (owner != -1)
{
	// Sets the position to the owners
	x = owner.x;
	y = owner.y;
}

// Checks if pause needed
if (can_pause && global.is_paused)
{
	// Exits the event before anything else can occur
	exit;	
}

// Sets if inital frame
if (init_frame)
{
	// Checks the particle system has been set inside a child object
	if (variable_instance_exists(self, "set_ps"))
	{
		// Create ps system
		var _new_ps = instance_create_layer(x, y, layer, obj_particle_manager);
		
		_new_ps.create_ps(set_ps, layer_get_name(layer), owner, can_pause, is_stream);
		
		if (is_scaled)
		{
			_new_ps.is_render_scaled = true;
			_new_ps.render_scale = (layer_get_depth(layer) - obj_camera_manager.plane_near) / 4000;
		}
		
		// Checks if the layer needs to self destroy
		if (is_layer_cleaned)
		{
			// Tells the new particle system to be detructive
			_new_ps.is_layer_cleaned = true;
			
			// Sets the new local layer for this object
			var _local_layer = layer_create(depth);
			layer = _local_layer;
		}
	
		// Updates the particle system to the objects position
		part_system_position(_new_ps.particle_sys, x, y);
	}
	else
	{
		// Destroys this emitter
		instance_destroy();	
}

	// Checks if the created particle system is a stream
	if (is_stream || !can_repeat)
	{
		// Destroys this emitter
		instance_destroy();	
	}
}
else
{
	if (is_effected_by_time_effects)
	{
		// Increment timer
		emitter_timer += global.update_time;
	}
	else
	{
		// Increment timer
		emitter_timer += global.timer_delta * 0.000001;
	}

	// Check if timer has surpased the rate
	if (emitter_timer >= emitter_rate)
	{
		// Reset timer
		emitter_timer = 0;
		
		// Create new ps system
		var _new_ps = instance_create_layer(x, y, layer, obj_particle_manager);
		_new_ps.create_ps(set_ps, layer_get_name(layer), owner, can_pause);
		
		if (is_scaled && room == rm_level_city)
		{
			_new_ps.is_render_scaled = true;
			_new_ps.render_scale = 1.69 * custom_scale * (layer_get_depth(layer) - obj_camera_manager.plane_near) / 4000;
		}
		
		if (!is_effected_by_time_effects)
		{
			_new_ps.can_pause = false;
			_new_ps.is_time_bypass = true;
		}
		
		// Checks if the layer needs to be cleaned
		if (is_layer_cleaned)
		{
			// Tells the new particle system to be detructive
			_new_ps.is_layer_cleaned = true;
			
			// Sets the new local layer for this object
			var _local_layer = layer_create(depth);
			layer = _local_layer;
		}
		
		// Used when emitter is played at offset but not quite destroyed
		if (is_force_deleted)
		{
			// Destroys this object
			instance_destroy();	
		}
	}
}