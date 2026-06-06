/// Sequence manager object
//  Object used to anchor live sequences to

// Set sequence used
set_sequence = -1;

// Variable used for if follows owner
owner = -1;

// Variable used for if sequence is effected by game pauses
can_pause = true;

// Can store arguments to be used later if nesscessary
stored_args = array_create(0, -1);

// Sets up inital after sequence functionality
has_death = false;
is_self_cleaning = false;
is_speed_adjusted = false;

// Flag for if the sequence can actually end (false means manager will not self destroy)
can_end = true;

// Function called when death set
set_death = function(_new_function)
{
	// Sets death flag to true
	has_death = true;

	// Stores the function
	stored_function = _new_function;
}

// Function called when creating new sequences
create_seq = function(_new_seq, _new_layer, _owner = -1, _can_pause = true, _is_speed_adjusted = false)
{
	// Updates owner variable
	owner = _owner;
	
	// Updates position to owner position if possible
	if (owner != -1)
	{
		// Sets the positions
		x = owner.x;
		y = owner.y;
	}
	
	// Sequence 
	seq_type = _new_seq;
	
	// Sets the variable to the set sequence on a specified layer
	set_sequence = layer_sequence_create(_new_layer, x, y, _new_seq);
	
	// Updates game pauses state
	can_pause = _can_pause;
	
	// Can be affected by speed adjustments
	is_speed_adjusted = _is_speed_adjusted;
	
	//show_debug_message("set sequence");
}

//show_debug_message("created sequence");