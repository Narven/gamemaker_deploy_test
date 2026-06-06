// If the game is not paused, animate properly, otherwise pause the sprite
if (global.update_time > 0.01)
{
	image_speed = (1 / current_animation_fps) * (1 / global.update_time);
}
else
{
	image_speed = 0;
	exit;
}

// When the animation finishes, randomly choose an animation from the current animation struct's "after" section
if(skeleton_animation_is_finished(0))
{
	var max_rand = 0;
	for(var i = 0; i < array_length(current_animation.after); i++)
	{
		max_rand += current_animation.after[i].chance;
	}
	
	var rand = random(max_rand);
	
	var next_anim = undefined;
	for(var i = 0; i < array_length(current_animation.after); i++)
	{
		rand -= current_animation.after[i].chance;
		if(rand <= 0)
		{
			swap_anim(current_animation.after[i].path);
			break;
		}
	}
	
	// Flag that the character isn't turning regardless of what animation was finished
	// as none of them end with the character turning and the turn animations need the flag reset
	turning = false;
	
	if(is_reloading)
	{
		finish_reload();
	}
}

// If the sprite wants to turn arund, wait until it is not currently turning to turn around
if(wants_to_turn)
{
	if(!turning)
	{
		if(is_standing)
		{
			swap_anim(["Stand", "Turn"]);
			is_standing = false;
		}
		else
		{
			swap_anim(["Cover", "Turn"]);
			is_standing = true;
		}
		
		turning = true;
		wants_to_turn = false;
	}
}

// Continue tracking how long the player has been reloading for if they are reloading
if(is_reloading)
{
	reload_time += global.timer_delta * 0.000001;
}