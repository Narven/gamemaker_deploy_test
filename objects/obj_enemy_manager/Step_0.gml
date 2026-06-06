// If the game is not paused, gather all enemies, obstacles, and bullets into the all_enemies array
if(!global.is_paused)
{
	// Gather all the enemies in depth order
	all_enemies = [];
	with(obj_shootable_parent)
	{
		var place_found = false;
		for(var i = 0; i < array_length(other.all_enemies); i++)
		{
			if(other.all_enemies[i].depth > depth)
			{
				place_found = true;
				array_insert(other.all_enemies, i, id);
				break;
			}
		}
		if(!place_found)
		{
			array_push(other.all_enemies, id);
		}
	}
	
	// Also gather the obstacles
	with(obj_obstacle_parent)
	{
		var place_found = false;
		for(var i = 0; i < array_length(other.all_enemies); i++)
		{
			if(other.all_enemies[i].depth > depth)
			{
				place_found = true;
				array_insert(other.all_enemies, i, id);
				break;
			}
		}
		if(!place_found)
		{
			array_push(other.all_enemies, id);
		}
	}
}