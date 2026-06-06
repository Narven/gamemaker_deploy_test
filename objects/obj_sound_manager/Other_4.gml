// Check if music has been set
if (current_bgm != -1)
{
	// Stop the current background music
	audio_stop_sound(current_bgm);
	
	// Unset the variable for background music
	current_bgm = -1;
}

// Switch statement for checking what room the game is in
switch (room)
{
	// If in main menu
	case rm_main_menu:
		// Set the splash screen music to play
		current_bgm = audio_play_sound(asset_bgm_splash, 100, true, bgm_level);
		break;
	
	// If in the main game room
	case rm_level_city:
		// Set the back ground music to play
		current_bgm = audio_play_sound(asset_bgm_gameplay, 100, true, bgm_level);
		break;
}