// If the button still registers as pressed, go to the main menu
if (current_button_state == BUTTON_STATE.PRESSED)
{
	play_button_sound();
	
	obj_menu_manager.change_state(SPLASH_STATE.MAIN);
}