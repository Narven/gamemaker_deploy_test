// Enumerator for the states a button can be in
enum BUTTON_STATE
{
	IDLE,
	HOVERED,
	PRESSED,
	SIZE
}

// Flag what state the button is currently in
current_button_state = BUTTON_STATE.IDLE;

// Store what menu state the button will be active in
active_state = SPLASH_STATE.START;

// Store a label to display on the button
button_text = "";

// Text draw settings
button_set_font = fnt_rationale_regular_12;
button_text_alignment = fa_center;

y_offset = 0;

current_button_scale = 1.0;
current_text_scale = 1.0;

target_button_scale = 1.0;
target_text_scale = 1.0;

button_scale_rate = 10;
text_scale_rate = 10;

current_colour = c_silver;
target_colour = c_silver;

colour_mix_value = 1.0;
colour_mix_rate = 10;

current_colour_blend = merge_colour(current_colour, target_colour, colour_mix_value);

// Store a sound effect that will play when the button is pressed
button_pressed_sfx = -1;

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