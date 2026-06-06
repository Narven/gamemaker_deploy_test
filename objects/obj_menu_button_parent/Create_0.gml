// Store what state the button is in
current_button_state = BUTTON_STATE.IDLE;

// Store the button's text and its location on the button
button_text = "QUIT";
button_set_font = fnt_rationale_regular_48;
button_text_alignment = fa_center;
y_offset = 0;

// Store the button's scalings and change rate
current_button_scale = 1.0;
current_text_scale = 1.0;

target_button_scale = 1.0;
target_text_scale = 1.0;

button_scale_rate = 10;
text_scale_rate = 10;

// Store the button's colours
current_colour = c_silver;
target_colour = c_silver;

colour_mix_value = 1.0;
colour_mix_rate = 10;

current_colour_blend = merge_colour(current_colour, target_colour, colour_mix_value);

// Store the SFX that plays when the button is pressed
button_pressed_sfx = snd_ui_menu_close;

// Function to play the pressed SFX at a level defined in the settings
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

// Virtual function that children will overwrite for specific functionality
press_function = function() {}