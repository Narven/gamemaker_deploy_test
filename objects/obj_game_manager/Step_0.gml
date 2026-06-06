// Store time-related values
global.curr_time = get_timer();
global.timer_delta = global.curr_time - global.start_time;
global.start_time = global.curr_time;

// Store an ideal delta time equivalent to 60fps because there's an issue in GameMaker right now that we're hard at work fixing where delta_time can return incorrect values.
global.timer_delta = 1000000 / 60;

// If there's no effect overlay, just set update_time to be timer_delta in seconds
if (!instance_exists(obj_effect_overlay))
{
	global.update_time = global.timer_delta * 0.000001;
}
else // Otherwise, modify update_time by the blocker alpha so it slows down over time
{
	global.update_time = global.timer_delta * 0.000001 * (1 - max(0, obj_effect_overlay.blocker_alpha));
	
	// Pause the game if the blocker alpha is at one
	if (obj_effect_overlay.blocker_alpha >= 1.0)
	{
		global.is_paused = true;
	}
	else // Otherwise resume it
	{
		global.is_paused = false;
	}
}

// If the window is not in focus, pause.
if(!window_has_focus())
{
	global.update_time = 0.0;
	global.is_paused = true;
	
	if (!instance_exists(obj_settings_manager) && !instance_exists(obj_lose_manager) && !instance_exists(obj_win_manager))
	{
		instance_create_layer(0,0, "Instances", obj_settings_manager);	
	}
}

// Depending on the current game state, perform different behaviours
switch(global.curr_game_state)
{
	// For 2 seconds, when the game starts, do nothing. Then start playing.
	// This gives time for the fade to pass and the wave banner to disappear
	case game_state.STARTING:
		state_timer += global.timer_delta * 0.000001;
		if(state_timer >= 2)
		{
			global.curr_game_state = game_state.PLAYING;
			state_timer = 0;
		}
		break;
		
	// In the playing state, track how long this state has been active
	case game_state.PLAYING:
		state_timer += global.timer_delta * 0.000001;
		break;
	
	// If the game is paused, do nothing.
	case game_state.PAUSED:
		break;
}

// If either of the HUD warning elements should be flashing, loop a timer for 0.6 seconds to sync them
if(obj_hud_ammo.is_warning || obj_hud_player.is_warning)
{
	warning_flash_timer += global.timer_delta * 0.000001;
	if(warning_flash_timer >= 0.6)
	{
		warning_flash_timer -= 0.6;
	}
}
else
{
	warning_flash_timer = 0;
}