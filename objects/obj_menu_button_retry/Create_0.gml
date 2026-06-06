event_inherited();

// Overwrite button-specific variables
button_text = "RETRY";

button_set_font = fnt_rationale_regular_48;

button_pressed_sfx = snd_ui_menu_close;

press_function = function() {
	// Create a snapshot of score and the wave number then restart the room (retry from the start of the wave)
	play_button_sound();
	obj_fade_manager.initiate_fade(0.5, function() {
		global.wave_snapshot = {
			has_been_used : false,
			wave_number : obj_wave_manager.wave_num,
			baseline_points : obj_game_manager.points_at_last_wave
		};
	
		room_restart();
	});
}