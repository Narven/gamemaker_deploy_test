// Checks if the owner currently exists
if (owner != -1)
{
	// Checks the owner is still in the room 
	if (instance_exists(owner.id))
	{
		if (angle_offset != 0 && (x_offset != 0 || y_offset != 0))
		{
			// Converts angle to radians
			var _theta = degtorad(angle_offset);

			// Calculates the adjusted repositioned angles from the set offsets and angle
			var _adjust_x = (x_offset * cos(_theta)) - (-y_offset * sin(_theta));
			var _adjust_y = (-y_offset * cos(_theta)) + (x_offset * sin(_theta));

			x = owner.x + _adjust_x;
			y = owner.y - _adjust_y;
		}
		else
		{
			// Sets the x and y positions by the offsets and the owners position
			x = owner.x + x_offset;
			y = owner.y + y_offset;
		}
	}
}

if (!is_render_scaled && (x != prev_x || y != prev_y))
{
	prev_x = x;
	prev_y = y;
	
	// Updates the particle system to the objects position
	part_system_position(particle_sys, x, y);
}


// Checks if the game is paused
if ((global.is_paused && can_pause) || !global.is_window_in_focus)
{
	// Stops updating the particle systems
	part_system_automatic_update(particle_sys, false)
}
else
{
	// Checks gamemanager exists
	if (instance_exists(obj_game_manager))
	{
		// Adds the game delta timer to the update buffer
		update_buffer += is_time_bypass ? global.timer_delta * 0.000001 : global.update_time;
		
		// Calculates the current delta time
		var _current_dt = global.timer_delta * 0.000001;
		
		// Clamps the updates to a maximum of 16 to prevent vfx lag
		update_buffer = clamp(update_buffer, 0, _current_dt * 16);
		
		// Repeats while the update buffer is greater than the time snapshot
		while (update_buffer >= _current_dt)
		{
			// Update the particle system
			part_system_update(particle_sys);
			
			// Remove time from the buffer timer
			update_buffer -= _current_dt;
		}
	}
	else
	{
		// Resumes updating the particle systems
		part_system_automatic_update(particle_sys, true)
	}
	
	// Checks if fading
	if (is_fading)
	{
		// Adds time passed to timer
		fade_timer += global.update_time;
	
		// Calculates the actual current alpha value between zero and one
		var _alpha = clamp(1 - ((1 / fade_life) * fade_timer), 0, 1);
	
		// Lerps the alpha to actual value
		fade_alpha = lerp(fade_alpha, _alpha, 0.1);
		
		// Sets the particle systems colour to white at the set alpha
		part_system_color(particle_sys, c_white, fade_alpha);
	}
}

// Checks if the particle system has finished
if (fade_alpha < 0.01 || (!is_stream && part_particles_count(particle_sys) == 0))
{
	// Destroys the object
	instance_destroy();
}