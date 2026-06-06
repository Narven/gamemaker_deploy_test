// Store what should be displayed as the label for the switch
switch_name = "NAME";

// The switch should start active
switch_value = true;
hover_scale = 1.0;

// Hover variables for whether the switch is currently hovered and if it should act hovered even if it isn't
hovered = false;
stale_hover = false;

// Flag if the switch is currently pressed
pressed = false;

// Store a sound effect for when the switch is swapped
button_pressed_sfx = obj_sound_manager.asset_ui_confirm;

// Function for playing a sound effect according to the sound manager's levels
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