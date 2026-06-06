event_inherited();

// Overwrite button-specific variables
button_text = "GameMaker";

button_set_font = fnt_rationale_regular_32;

button_pressed_sfx = snd_ui_menu_open;

// If possible, open the GameMaker URL when pressed
press_function = function() {
	if(global.is_url_enabled)
	{
		play_button_sound();
		url_open("https://www.gamemaker.io");
	}
}