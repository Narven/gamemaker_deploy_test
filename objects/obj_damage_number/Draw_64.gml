// Find where the damage number would appear on screen from in the room
var _matrixViewProj = matrix_multiply(obj_camera_manager.view_mat, obj_camera_manager.proj_mat);

var point = world_to_screen(x, y, depth, _matrixViewProj, false, room_width, room_height);

if(point != undefined)
{
	// Draw the text to the screen
	// Set draw settings
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	draw_set_alpha(image_alpha);
	draw_set_font(fnt_damage_numbers);

	// If the damage instance was a crit, make the number yellow
	if(is_crit)
	{
		draw_set_colour(#efd04e);
	}
	else // Otherwise it's white
	{
		draw_set_colour(c_white);
	}
	
	
	// Draw the number
	draw_text_transformed(point[0], point[1], damage_amount, image_xscale, image_yscale, image_angle);
	
	// Reset draw settings
	draw_set_alpha(1);
	draw_set_colour(c_white);
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
}