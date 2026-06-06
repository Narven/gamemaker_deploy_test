// If the game is paused, do nothing,
if(global.is_paused)
{
	exit;
}

// Track the aim position differently based on the player's input style
switch(input_style)
{
	// If the player is using a mouse, just find its regular position on the screen
	case input_styles.MOUSE:
		mouse_from_centre = [
			get_mouse_x_real() - room_width / 2, 
			get_mouse_y_real() - room_height / 2
			];
			
		mouse_point[0] = room_width / 2 + mouse_from_centre[0];
		mouse_point[1] = room_height / 2 + mouse_from_centre[1];
		break;
	
	// If the player is using touch controls, find the touch position within a rectangle on the bottom left of the screen and multiply out to the whole screen.
	case input_styles.TOUCH:
		var mouse_move = [0, 0];
		if(mouse_check_button_pressed(mb_left))
		{
			last_mouse = [get_mouse_x_real(), get_mouse_y_real()];
		}
		else if(mouse_check_button(mb_left))
		{
			mouse_move[0] = get_mouse_x_real() - last_mouse[0];
			mouse_move[1] = get_mouse_y_real() - last_mouse[1];
			
			last_mouse = [get_mouse_x_real(), get_mouse_y_real()];
		}
		
		if(point_distance(0, 0, mouse_move[0], mouse_move[1]) < 250)
		{
			mouse_from_centre[0] += mouse_move[0];
			mouse_from_centre[1] += mouse_move[1];
		}
		
		mouse_point[0] = room_width / 2 + mouse_from_centre[0];
		mouse_point[1] = room_height / 2 + mouse_from_centre[1];
		break;
}