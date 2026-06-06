event_inherited();

// Overwrite button-specific variables
button_text = "QUIT";

button_set_font = fnt_rationale_regular_48;

button_pressed_sfx = snd_ui_menu_close;

on_load = true;

press_function = function()
{
	// Go back to the main menu
	play_button_sound();
	obj_fade_manager.initiate_fade(0.5, function(){room_goto(rm_main_menu)});
}