// If the game isn't paused and there is not a wave start sequnce
if(!global.is_paused && wave_prompt == undefined)
{
	// Count down to the next enemy spawn
	enemy_spawn_timer -= global.timer_delta * 0.000001;
	
	if(obj_enemy_manager.active_enemies == 0)
	{
		enemy_spawn_timer = min(enemy_spawn_timer, 0.5);
	}
	
	// If there is space for another enemy, spawn another one and reset the timer
	if(obj_enemy_manager.active_enemies < curr_wave.max_enemies && obj_enemy_manager.active_enemies + enemies_destroyed_this_wave < curr_wave.enemies_to_progress)
	{
		if(enemy_spawn_timer <= 0)
		{
			// Reset the timer
			enemy_spawn_timer = curr_wave.enemy_spawn_cooldown;
			
			// Create a new enemy that doesn't overlap with other enemies
			for(var i = 0; i < curr_wave.enemies_per_spawn; i++)
			{
				if(obj_enemy_manager.active_enemies < curr_wave.max_enemies && obj_enemy_manager.active_enemies + enemies_destroyed_this_wave < curr_wave.enemies_to_progress)
				{
					obj_enemy_manager.spawn_enemy(curr_wave.enabled_enemies);
				}
			}
		}
	}
	else // If there's no space, hold the countdown at 1 second so it doesn't immediately spawn another enemy
	{
		enemy_spawn_timer = max(0.5, enemy_spawn_timer);
	}
	
	// If enough enemies have been destroyed, go to the next wave
	if(enemies_destroyed_this_wave == curr_wave.enemies_to_progress)
	{
		new_wave_timer -= global.timer_delta * 0.000001;
		if(new_wave_timer <= 0)
		{
			next_wave();
		}
	}
}