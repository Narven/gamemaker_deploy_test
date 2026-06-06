if (obj_input_manager.input_style != input_styles.TOUCH)
{
    instance_destroy();
}

current_button_state = BUTTON_STATE.IDLE;

current_button_scale = 1.0;

target_button_scale = 1.0;

button_scale_rate = 10;

current_colour = c_silver;
target_colour = c_silver;

colour_mix_value = 1.0;
colour_mix_rate = 10;

current_colour_blend = merge_colour(current_colour, target_colour, colour_mix_value);

button_pressed_sfx = obj_sound_manager.asset_ui_open;

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