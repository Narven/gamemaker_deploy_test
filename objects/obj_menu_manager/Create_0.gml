// Capture the start time for use in later calculations
global.start_time = get_timer();

// Set what the game uses as the time between frames (in milliseconds) so
global.timer_delta = 1000000 / 60;

enum SPLASH_STATE
{
	START,
	MAIN,
	SETTINGS,
	LOADING,
	QUIT,
	SIZE
}

// Flag that the game isn't paused
global.is_paused = false;

// If there is no has_started variable, find whether the game is being run through an application window or in a browser of some sort
if (!variable_global_exists("has_started"))
{
	global.has_started = false;
	
	if (os_type != os_windows && os_type != os_macosx && os_type != os_linux)
	{
		global.is_standalone = false;
	}
	else
	{
		global.is_standalone = true;
	}
    
    // Check if html5
    if (os_browser != browser_not_a_browser && os_type != os_gxgames)
    {
    	global.is_html5 = true;
    }
    else
    {
        global.is_html5 = false;	
    }
	
	// Enable VFX and disable debug tools
	global.vfx_enabled = true;
	global.DB_show_elements = false;
	
	// Flag that the game window is in focus
	global.is_window_in_focus = true;
	
	// Store how many milliseconds was between the last frame and this one
	global.update_time = 0;
	
	// Hide the cursor
	if(window_get_cursor() != cr_none) window_set_cursor(cr_none);
}

message_timer = 0;
runtime_id = real(string_digits(string_copy(GM_runtime_version, 1, 7)));

// Start on the start menu
current_splash_state = SPLASH_STATE.START;

// Create the environment particle systems that cannot be set in the room editor due to scaling
var _effect = -1;

_effect = instance_create_layer(1920, 721, "Assets_1", obj_particle_manager);
_effect.create_ps(ps_fog_bg_additive, "Assets_1", _effect, true, true);

_effect = instance_create_layer(2482, 918, "Assets_1", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_bg_splash, "Assets_1", _effect, true, true);

_effect = instance_create_layer(3234, 543, "Assets_1", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_bg_splash, "Assets_1", _effect, true, true);

_effect = instance_create_layer(2017, 1594, "Assets_6", obj_particle_manager);
_effect.create_ps(ps_fog_bg_additive, "Assets_6", _effect, true, true);

_effect = instance_create_layer(1468, 1869, "Assets_6", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_fg, "Assets_6", _effect, true, true);

_effect = instance_create_layer(3125, 1798, "Assets_6", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_fg, "Assets_6", _effect, true, true);

_effect = instance_create_layer(2454, 1692, "Assets_6", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_bg, "Assets_6", _effect, true, true);

_effect = instance_create_layer(1658, 1728, "Assets_6", obj_particle_manager);
_effect.create_ps(ps_fog_fg, "Assets_6", _effect, true, true);

_effect = instance_create_layer(1920, 1085, "Assets_3", obj_particle_manager);
_effect.create_ps(ps_debris_fg, "Assets_3", _effect, true, true);

_effect = instance_create_layer(1836, 539, "Assets_3", obj_particle_manager);
_effect.create_ps(ps_debris_fg, "Assets_3", _effect, true, true);

_effect = instance_create_layer(1942, 1785, "Assets_3", obj_particle_manager);
_effect.create_ps(ps_fog_fg, "Assets_3", _effect, true, true);

_effect = instance_create_layer(1906, 1966, "Assets_3", obj_particle_manager);
_effect.create_ps(ps_fog_fg, "Assets_3", _effect, true, true);

_effect = instance_create_layer(3693, 1881, "Assets_3", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_fg, "Assets_3", _effect, true, true);

_effect = instance_create_layer(438, 748, "Assets_4", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_fg, "Assets_4", _effect, true, true);

_effect = instance_create_layer(376, 677, "Assets_4", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_fg, "Assets_4", _effect, true, true);

_effect = instance_create_layer(1920, 2564, "Assets_4", obj_particle_manager);
_effect.create_ps(ps_fog_fg, "Assets_4", _effect, true, true);

// Simulate the particles for a few updates to make them not look like the emittors haven't emitted anything yet
with (obj_particle_manager)
{
	simulate_effect(3);	
}

// Function to move to a different menu state, resetting the button states as well if need be
change_state = function(_new_state, _reset_buttons = false)
{		
	// If moving to the splash state, reset all the buttons to unpressed
	if (_new_state == current_splash_state)
	{
		with (obj_ui_splash_button_parent)
		{	
			//show_debug_message("Button checked");
		
			if (current_button_state == BUTTON_STATE.PRESSED)
			{
				target_button_scale = 1.0;
				target_text_scale = 1.0;
	
				current_colour = current_colour_blend;
				target_colour = c_silver;
				colour_mix_value = 0.0;

				current_button_state = BUTTON_STATE.IDLE;
			}
		}
	
		return;
	}
	
	// Save the new state
	current_splash_state = _new_state;
	
	// Set the appropriate UI layer to visible
	switch (current_splash_state)
	{
		case SPLASH_STATE.START:
			
			layer_set_visible("Splash", true);
			
		break;
		
		case SPLASH_STATE.MAIN:
			
			layer_set_visible("Splash", false);
			
			// Flag that the game has been started
			global.has_started = true;
			
			// If the game is in its own application window, let the user choose to exit the game from within it
			if (!global.is_standalone)
			{
				layer_set_visible("MainMenu", true);
			}
			else
			{
				layer_set_visible("MainMenu_Extra", true);
			}
		
		break;
		
		case SPLASH_STATE.SETTINGS:
		
			current_splash_state = SPLASH_STATE.SETTINGS;
			
			// Create a settings menu
			if (!instance_exists(obj_settings_manager))
			{
				instance_create_layer(0,0, "Instances", obj_settings_manager);	
			}
		
		break;
		
		case SPLASH_STATE.LOADING:
			// Go to the initialisation room (glorified loading screen) so the texture page loading can be better hidden
			if (!global.is_standalone)
			{
				layer_set_visible("MainMenu", false);
			}
			else
			{
				layer_set_visible("MainMenu_Extra", false);
			}

			room_goto(rm_init);
		
		break;
		
		case SPLASH_STATE.QUIT:
		
			// Quit the game
			game_end();
		
		break;
	}
	
	// Set all the buttons to unpressed
	with (obj_ui_splash_button_parent)
	{	
		//show_debug_message("Button checked");
		
		if (current_button_state == BUTTON_STATE.PRESSED)
		{
			target_button_scale = 1.0;
			target_text_scale = 1.0;
	
			current_colour = current_colour_blend;
			target_colour = c_silver;
			colour_mix_value = 0.0;

			current_button_state = BUTTON_STATE.IDLE;
		}
		
		// And reset them to their original state if needed
		if (_reset_buttons)
		{
			current_button_state = BUTTON_STATE.IDLE;
			
			current_button_scale = target_button_scale;
			current_text_scale = target_text_scale;
			
			image_xscale = current_button_scale;
			image_yscale = current_button_scale;

			current_colour = target_colour;

			colour_mix_value = 1.0;

			current_colour_blend = merge_colour(current_colour, target_colour, colour_mix_value);
		}
	}
}

// If the has_started flag has already been triggered, go straight to the main menu
if (global.has_started)
{
	change_state(SPLASH_STATE.MAIN, true);
}
else // Otherwise start with the start screen
{
	change_state(SPLASH_STATE.START, true);
}