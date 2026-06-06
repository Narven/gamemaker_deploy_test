// Store what should be displayed as the label for the bar
bar_name = "NAME";

// Store how full the bar is
bar_percent = 1.0;

// Store how large the bar should be while hovered
hover_scale = 1.0;

// Flag whether the bar is hovered or should display as such even if it currently isn't
hovered = false;
stale_hover = false;

// Flag whether the button is currently being pressed
pressed = false;

// Store a sound effect for when the button is pressed
button_pressed_sfx = obj_sound_manager.asset_ui_confirm;

// Function to play a sound effect according to the sound manager's audio levels
play_button_sound = function()
{
	if (button_pressed_sfx != -1)
	{
		if (obj_sound_manager.current_ui != -1 && audio_is_playing(obj_sound_manager.current_ui))
		{
			audio_sound_gain(obj_sound_manager.current_ui, 0, 100);
			obj_sound_manager.current_ui = -1;
		}
		
		obj_sound_manager.current_ui = audio_play_sound(button_pressed_sfx, 100, false, obj_sound_manager.ui_level, 0.05);
	}
}