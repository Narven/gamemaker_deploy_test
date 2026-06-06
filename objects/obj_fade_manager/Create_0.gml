// Create enumerator to show where in the fade state the manager is
enum fade_states { IN, OUT, IDLE}

orientation = display_get_orientation();

// Store globally whether there is currently a fade in effect for use with other objects
global.is_fading = false;

// Store the amount of fade currently in effect
fade_amount = 0;

// Store how long the current fade should take
fade_time = 1;

// Store what state the fade manager is in for internal use
fade_state = fade_states.IDLE;

// Store a reference to a function that will be carried out while the screen is fully black
post_fade_behaviour = function() {};

// Variable that stores whether we should be going to fullscreen on mobile or not
fullscreen = false;

// Function to start a fade
function initiate_fade(new_fade_time, new_post_fade_behaviour)
{	
	if(fade_state != fade_states.IDLE)
	{
		show_debug_message("Fade not initiated due to pre-existing fade");
		exit;
	}
	
	if(new_fade_time <= 0)
	{
		show_debug_message("Fade not initiated because time was invalid");
		exit;
	}
	
	// State that the game is currently fading
	global.is_fading = true;
	
	// Store the the screen should fade out (to black)
	fade_state = fade_states.OUT;
	
	// Store the post-fade behaviour and how long the full fade should take
	post_fade_behaviour = new_post_fade_behaviour;
	fade_time = new_fade_time;
}

render_scale_width = 1;
render_scale_height = 1;

render_scale = 1;