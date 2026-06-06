/// Base emitter object
//  Object used for emiting controlled particle effects from sequences

// Timer for the emitter
emitter_timer = 0;

// State for knowing if this is the inital frame object was created on
init_frame = true;

// Used when paticles need to self destroy their layers
is_layer_cleaned = false;

// Used for when playing in sequence at an offset
is_force_deleted = false;