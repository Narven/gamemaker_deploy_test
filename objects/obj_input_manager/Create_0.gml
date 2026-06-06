// Create an enumerator for which input style the player is using
enum input_styles {MOUSE, TOUCH};
input_style = input_styles.MOUSE;

// Store the mouse's position on the screen and its distance from the centre of the screen
mouse_point = [room_width / 2, room_height / 2];
mouse_from_centre = [0, 0];
last_mouse = [0, 0];

mouse_speed = 0;

// Flag for it the GameMaker URL is accessible from the device the program is running on
global.is_url_enabled = false;

mobile = false;
platform_type = "";

switch(os_type)
{
	case os_operagx:
		var _info = os_get_info();
		var _info_encoded = json_encode(_info);
		var _info_struct = json_parse(_info_encoded);

		struct_foreach(_info_struct, 
			function (_name, _value) 
			{
				if (_name == "userAgentString")  
		        {
					 platform_type += string(_value); 
		        }
				
				if (_name == "mobile")
				{
					mobile = _value;
				}
			});

		ds_map_destroy(_info);

		// Sets quality based on platform detected
		if (mobile)
		{
			global.is_url_enabled = true;
			input_style = input_styles.TOUCH;
			
			window_set_fullscreen(true);
			
			if (string_count("iPhone", platform_type) >= 1 || string_count("iPad", platform_type) >= 1)
            {
                global.is_url_enabled = false;
            }
			if(instance_exists(obj_fade_manager))
			{
				obj_fade_manager.fullscreen = true;
			}
		}
		else
		{
			global.is_url_enabled = true;
			input_style = input_styles.MOUSE;
		}
		break;
	case os_windows:
	case os_linux:
	case os_macosx:
		global.is_url_enabled = true;
		input_style = input_styles.MOUSE;
		break;
	case os_android:
	case os_ios:
		global.is_url_enabled = true;
		input_style = input_styles.TOUCH;
		break;
}
