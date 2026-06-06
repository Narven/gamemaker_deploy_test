// If the button still registers as pressed, move to the loading screen
if (current_button_state == BUTTON_STATE.PRESSED)
{
	play_button_sound();
	obj_fade_manager.initiate_fade(0.5, function()
	{
		obj_menu_manager.change_state(SPLASH_STATE.LOADING);
	}
	);
}