// If something has triggered an animation change, then try to change animation
if(trigger_animation_change)
{
	// If there are no more parts of the current animation, go to the next one after the current on according to the library
	if(sprite_index == current_animation.out || 
	sprite_index == current_animation.during && current_animation.out == undefined ||
	sprite_index == current_animation.in && current_animation.during == undefined && current_animation.out == undefined)
	{
		// Reset the flag
		trigger_animation_change = false;
		
		// Find the next animation
		next_anim ??= current_animation.after;
		
		// Store the next animation as the current animation
		current_animation = find_animation(next_anim, global.enemy_animations);
		current_animation ??= default_anim;
		curr_anim_path = [];
		array_copy(curr_anim_path, 0, next_anim, 0, array_length(next_anim));
		next_anim = undefined;
		
		// Find the earliest part of the animation available
		if(current_animation.in != undefined) sprite_index = current_animation.in;
		else if(current_animation.during != undefined) sprite_index = current_animation.during;
		else if(current_animation.out != undefined) sprite_index = current_animation.out;
		else {current_animation = default_anim; sprite_index = current_animation.during;};
		
		// Hold the next movement direction to take (undefined if static)
		curr_move_dir = next_move_dir;

		// If the enemy is going into a movement, reset the next movement direction and hold that it's not idle		
		if(next_move_dir != undefined) 
		{
			next_move_dir = undefined;
			idle = false;
		}
		else // Otherwise, hold that it is idle and reset the movement timer
		{
			idle = true;
			move_timer = move_cooldown;
			curr_move_dist = 0;
		}
	}
	else // Otherwise, just go to the next animation part available
	{
		if(sprite_index == current_animation.in)
		{
			sprite_index = current_animation.during;
			sprite_index ??= current_animation.out;
		}
		else if(sprite_index == current_animation.during)
		{
			sprite_index = current_animation.out;
			trigger_animation_change = true;
		}
	}
}
else // Otherwise, the animation part has naturally ended so go to the next animation part available
{
	switch(sprite_index)
	{
		case current_animation.in:
			sprite_index = current_animation.during;
			if(sprite_index == undefined)
			{
				sprite_index = current_animation.out;
				trigger_animation_change = true;
			}
			break;
		case current_animation.during:
			if(current_animation.can_loop)
			{
				image_index = 0;
			}
			else
			{
				sprite_index = current_animation.out;
				trigger_animation_change = true;
			}
			break;
	}
}