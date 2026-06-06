// Don't allow movement if the game is paused
if(global.is_paused)
{
	exit;
}

// Centre the camera about a point just above the player character
// Give the centring an offset based on the mouse's position
var camera_x_offset = (obj_input_manager.mouse_from_centre[0] / (room_width / 2));
	
var y_pos = ((room_height / 2 + obj_input_manager.mouse_from_centre[1] + obj_player_manager.fake_recoil[1] / (1 - 0.4 * zoom)) - room_height * 0.85) / (room_height * 0.1);
var camera_y_offset = 2*arctan(y_pos)/pi;

camera_position = [
	lerp(camera_position[0], room_width / 2 - 80 * camera_x_offset, 0.2),
	lerp(camera_position[1], room_height / 2 - 80 + 80 * camera_y_offset, 0.2),
	plane_near + 500 * zoom
]
	
camera_lookat = [
	lerp(camera_lookat[0], room_width / 2 + 30 * (1 - camera_x_offset) + obj_input_manager.mouse_from_centre[0] * zoom * 0.6, 0.2),
	lerp(camera_lookat[1], room_height / 2 + 40 + 60 * camera_y_offset + obj_input_manager.mouse_from_centre[1] * zoom * 0.6, 0.2),
	layer_get_depth("Character")
]

// Build new view and projection matrices
view_mat = matrix_build_lookat(
	camera_position[0] + camera_offset_position[0], camera_position[1] + camera_offset_position[1], camera_position[2] + camera_offset_position[2], 
	camera_lookat[0] + camera_offset_position[0], camera_lookat[1] + camera_offset_position[1], camera_lookat[2] + camera_offset_position[2],
	0, 1, 0);
		
proj_mat = matrix_build_projection_perspective_fov(30 - 60 * zoom, 16 / 9, 1, plane_far - plane_near + 1);