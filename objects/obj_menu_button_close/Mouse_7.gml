// Close the settings menu and then destroy itself
play_button_sound();

with (obj_settings_manager)
{
	if (menu_seq != -1 && instance_exists(menu_seq))
	{
		instance_destroy(menu_seq);
		menu_seq = -1;
	}

	if (room == rm_main_menu)
	{
		obj_menu_manager.change_state(SPLASH_STATE.MAIN);
	}

	instance_destroy();	
}