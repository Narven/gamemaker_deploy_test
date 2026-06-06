// Recalculate how far through the ammo bar the transparency should start
// If the player is not reloading, lerp towards the percentage of ammo is left
if(!obj_player_manager.is_reloading)
{
	fake_ammo_count = obj_player_manager.ammo_count;
	mag_point = obj_player_manager.ammo_count / obj_player_manager.ammo_max;
	
	fake_mag_point = lerp(fake_mag_point, mag_point, 0.2)
	
	// If it's close enough to the correct point, just make it match
	if(abs(fake_mag_point - mag_point) <= 0.01)
	{
		fake_mag_point = mag_point;
	}
}
else // Otherwise, set the point exactly at the percentage of the way through the reload the player is at
{
	fake_ammo_count = 0;
	mag_point = obj_player_manager.player_character.get_reload_progress();
	
	fake_mag_point = mag_point;
}