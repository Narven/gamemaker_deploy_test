event_inherited();

button_text = "REPLAY";

button_set_font = fnt_rationale_regular_48;

button_pressed_sfx = snd_ui_menu_close;

press_function = function() {
	// Restart the room (restart the game)
	play_button_sound();
	obj_fade_manager.initiate_fade(0.5, function() {
		room_restart();
	});
}