/// Emitter object
//  Used to emitt a controlled particle system from a sequence

// Custom layer for this emitter
var _local_layer = layer_create(depth - 1);
layer = _local_layer;

// Emitter setup
emitter_rate = 99;

// Sets the particle effect asset
set_ps = ps_menu_open;
owner = self;

// Sets the emitter pause state
can_pause = false;

// Check for if affected by time effects
is_effected_by_time_effects = false;

// State for if emitter is stream or burst
is_stream = false;

// State for if the emitter can repeat after playing
can_repeat = false;

// Inherit the parent event
event_inherited();

// Hardset values for this ps emitter
init_frame = false;
emitter_timer = emitter_rate - 0.133; //-0.133 used as 4 frames of 30fps animation

is_scaled = true;
custom_scale = 1;

// Cleanup variables
is_force_deleted = true;
is_layer_cleaned = true;