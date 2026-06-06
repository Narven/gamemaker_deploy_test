/// Load Room object
// Used on the games loading screen to make sure all the assets have loaded in before changing rooms to the actual game

// Array of games texure groups names
texture_group_names = ["far_assets", "stage_assets", "vfx_sprites", "vignette_textures", "enemies", "player", "ui_hud_sprites", "vfx_animations", "ground", "cover"];

// Flag for knowing if this object has triggered and "loaded" in
has_triggered = false;

// Debug meesage
show_debug_message("Started prefetching textures @ " + string(current_time));

// Loops through the texture group names
for (var _i = 0; _i < array_length(texture_group_names); _i++)
{
	// Checks if the current group has been fetched yet
	if (texturegroup_get_status(texture_group_names[_i]) != texturegroup_status_fetched)
	{
		// Loads in the current group
		texturegroup_load(texture_group_names[_i], true);
	}
}

// Store the room to go into after loading is complete
post_load_room = undefined;

// Load in function
load_in = function(_room)
{
	post_load_room = _room;
	
	// Creates temp flag for knowing if room has finished loading in
	var _has_loaded = true;
	
	// Loops through the texture group names
	for (var _i = 0; _i < array_length(texture_group_names); _i++)
	{
		// Checks if the current group has been fetched yet
		if (texturegroup_get_status(texture_group_names[_i]) != texturegroup_status_fetched)
		{
			// Sets flag to false
			_has_loaded = false;
			// Breaks out of the loop
			break;
		}
	}
	
	// Checks the triggered flag hasnt occured and all the texures have loaded
	if (!has_triggered && _has_loaded)
	{
		// Sets the triggered flag to true
		has_triggered = true;
		
		// Debug message
		show_debug_message("Finished prefetching all textures @ " + string(current_time));
		
		// Go to specified room
		obj_fade_manager.initiate_fade(0.5, function() {room_goto(post_load_room)});
	}
}