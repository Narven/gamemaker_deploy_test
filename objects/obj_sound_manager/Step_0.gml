// Loop through the sound effects manager
for (var _i = 0; _i < array_length(current_sfx); _i++)
{
	// Check if the sound effect no longer exists or isnt playing and isnt paused
	if (!audio_exists(current_sfx[_i]) || (!audio_is_paused(current_sfx[_i]) && !audio_is_playing(current_sfx[_i])))
	{
		// Delete the sound effect from the array
		array_delete(current_sfx, _i, 1);
		
		// Decrement the array
		_i--;
	}
}