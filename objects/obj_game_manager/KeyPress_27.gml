// If the game is won or lost already, do nothing
if (instance_exists(obj_lose_manager) || instance_exists(obj_win_manager))
{
	exit;	
}

// Otherwise pause the game
if (!instance_exists(obj_settings_manager))
{
	instance_create_layer(0,0, "Instances", obj_settings_manager);
	play_button_sound();
}