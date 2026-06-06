// Creates an effect over the screen
if (!instance_exists(obj_effect_overlay))
{
	var _bg = instance_create_layer(0, 0, "Instances", obj_effect_overlay);
	_bg.set_owner(self, BLUR_TYPE.DESATURATE);	
}
else
{
	obj_effect_overlay.set_owner(self, BLUR_TYPE.DESATURATE);	
}

// Create an instance of the sequence that holds the lose menu
menu_seq = instance_create_layer(room_width / 2, room_height / 2, "Menu", obj_sequence_manager);
menu_seq.create_seq(seq_losescreen, "Menu", menu_seq, false, false);
menu_seq.can_end = false;

// Hold the sound effect that will play when the left mouse button is pressed during the lose screen
button_pressed_sfx = obj_sound_manager.asset_ui_confirm;

// Function to play a sound effect according to the sound manager's levels
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