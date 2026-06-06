// Function to load all assets for room rm_level_city
function load_level()
{
	obj_asset_loader.load_in(rm_level_city)
}

// Function to smoothstep
function smoothstep(_start, _end, _value)
{
	return lerp(_start, _end, _value * _value * (3 - 2 * _value));
}

// Function to play a random swoosh sound
function play_swoosh_sfx()
{
	audio_play_sound(choose(obj_sound_manager.asset_ui_wave_swoosh_1, obj_sound_manager.asset_ui_wave_swoosh_2), 50, false, obj_sound_manager.ui_level, 0.05);
}

// Pause the win or loss menu, whichever is active.
function pause_sequence_menu()
{
	if (instance_exists(obj_lose_manager))
	{
		layer_sequence_pause(obj_lose_manager.menu_seq.set_sequence);
	}
	else if (instance_exists(obj_win_manager))
	{
		layer_sequence_pause(obj_win_manager.menu_seq.set_sequence);
	}
}

function get_mouse_x_real() 
{
    if (global.is_html5)
    {
        var _actual_width = 3840;
        var _scale_width = _actual_width / browser_width;
        var _x = window_mouse_get_x() * _scale_width;
        
        if (_scale_width > 2160 / browser_height)
        {
              return _x;
        }
        else 
        {
            return mouse_x;
        }
    }
    else 
    {
    	return mouse_x;
    }
}
function get_mouse_y_real() 
{
    if (global.is_html5)
    {
        var _actual_height = 2160;
        var _scale_height = _actual_height / browser_height;
        
        if (_scale_height > 3840 / browser_width)
        {
              return window_mouse_get_y() * _scale_height;
        }
        else 
        {
            return mouse_y;
        }
    }
    else 
    {
    	return mouse_y;
    }
}