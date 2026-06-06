// Go back to the previous menu
// Destroy the menu sequence
if (menu_seq != -1 && instance_exists(menu_seq))
{
	instance_destroy(menu_seq);
	menu_seq = -1;
}

// If this is in the main menu, tell the menu manager to go back to the main menu
if (room == rm_main_menu)
{
	obj_menu_manager.change_state(SPLASH_STATE.MAIN);
}

// Play a sound effect and destroy the menu
play_button_sound();
instance_destroy();