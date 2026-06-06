// If a wave snapshot exists and it hasn't been used yet, load its data
if(variable_global_exists("wave_snapshot"))
{
	if(!global.wave_snapshot.has_been_used)
	{
		layer_sequence_destroy(wave_prompt);
		set_wave(global.wave_snapshot.wave_number);
		obj_game_manager.points = global.wave_snapshot.baseline_points;
		obj_game_manager.points_at_last_wave = global.wave_snapshot.baseline_points;
		
		global.wave_snapshot.has_been_used = true;
	}
}