/// Particle manager object
//  Used for attaching vfx and other particle systems to

// Empty variable for setting the particle system to
particle_sys = -1;

// Variable used for if follows owner
owner = -1;

// Variable used offsets
angle_offset = 0;
x_offset = 0;
y_offset = 0;

// Variable for checking if the particle system is effected by pauses
can_pause = true;

// State for when emitter is a stream and not a burst
is_stream = false;

// Variables used for fading the particle system
is_fading = false;
fade_timer = 0.0;
fade_life = 0.0;
fade_alpha = 1.0;

// Layer particle system is created on is self destroying when finished
is_layer_cleaned = false;

// Update timer
update_buffer = 0;

// Flags for if the patricle manager needs to be drawns in a draw end event
late_draw = false;

// Flag used for if the particle manager can ignore in game time
is_time_bypass = false;

// Death flag
has_death = false;

// Render scale
is_render_scaled = false;
render_scale = 1.0;

// Scale used when rendering the particle effect
set_surface = -1;
set_surface_width = 0;
set_surface_height = 0;
set_surface_scale = 1;

prev_x = x;
prev_y = y;

// Function used for setting particle systems angle
set_angle = function(_new_angle)
{
	// Sets angle offset
	angle_offset = _new_angle;
	// Updates particle systems angle
	part_system_angle(particle_sys, angle_offset);
}

// Function used for setting particle systems offset position
set_offset = function(_x_offset, _y_offset)
{
	if (_x_offset == 0 && _y_offset == 0)
	{	
		return;
	}
	
	// Offset variables set to new temp variables passed in
	x_offset = _x_offset;
	y_offset = _y_offset;
	
	// Positions adjusted by offsets
	x += x_offset;
	y += y_offset;
	
	// Particle position repositioned
	part_system_position(particle_sys, x, y);
	
	prev_x = x;
	prev_y = y;
}

// Function used for setting particle system
create_ps = function(_new_ps, _layer, _owner = -1, _can_pause = true, _is_stream = false)
{
	// Sets the owner
	owner = _owner;
	
	// Sets the pause state
	can_pause = _can_pause;
	
	// Sets the stream state
	is_stream = _is_stream;
	
	// Creates particle system
	particle_sys = part_system_create_layer(_layer, false, global.vfx_enabled ? _new_ps : ps_empty);
	
	// Updates particle system position
	part_system_position(particle_sys, x, y);
	
	prev_x = x;
	prev_y = y;
	
	// Stops updating the particle systems
	part_system_automatic_update(particle_sys, false)
}

// Function used for fading out particle system
fade_ps = function(_fade_time)
{
	// Changes the fading state to true
	is_fading = true;
	
	// Sets the fade life to fade time
	fade_life = _fade_time;
}

set_render_scale = function(_enabled, _scale = 1.0)
{
	is_render_scaled = _enabled;
	
	// Sets the automatic draw for the particle system to the appropriate value
	part_system_automatic_draw(particle_sys, !is_render_scaled);
	
	render_scale = _scale;
}

// Function used when setting up late draw
set_late_draw = function(_is_end)
{
	// Sets the late draw flag
	late_draw = _is_end;
	
	// Sets the automatic draw for the particle system to the appropriate value
	part_system_automatic_draw(particle_sys, !late_draw);
}

// Function used to simulate running the effect for a set amount of time
simulate_effect = function(_time)
{
	while (_time > 0)
	{
		part_system_update(particle_sys);
		_time -= global.timer_delta * 0.000001;
	}
}