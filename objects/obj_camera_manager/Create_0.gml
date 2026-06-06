// Set up basic camera variables
camera = camera_create();

// Zoom related variables
zoom = 0;
target_zoom = 0;

// Store the near and far planes
plane_near = -6000;
plane_far = 18000;

// Centre the camera about a point just above the player character
// Give the centring an offset based on the mouse's position
var camera_x_offset = (obj_input_manager.mouse_from_centre[0] / (room_width / 2));
	
var y_pos = ((room_height / 2 + obj_input_manager.mouse_from_centre[1] + obj_player_manager.fake_recoil[1] / (1 - 0.4 * zoom)) - room_height * 0.85) / (room_height * 0.1);
var camera_y_offset = 2*arctan(y_pos)/pi;

camera_position = [
	room_width / 2 - 80 * camera_x_offset,
	room_height / 2 - 80 + 80 * camera_y_offset,
	plane_near + 500 * zoom
]
	
camera_lookat = [
	room_width / 2 + 30 * (1 - camera_x_offset) + obj_input_manager.mouse_from_centre[0] * zoom * 0.6,
	room_height / 2  + 100 - 60 + 60 * camera_y_offset + obj_input_manager.mouse_from_centre[1] * zoom * 0.6,
	layer_get_depth("Character")
]

// Build basic view and projection matrices
view_mat = matrix_build_lookat(
	camera_position[0], camera_position[1], camera_position[2], 
	camera_position[0] + camera_lookat[0], camera_position[1] + camera_lookat[1], camera_position[2] + camera_lookat[2],
	0, 1, 0);

proj_mat = matrix_build_projection_perspective_fov(30 - 60 * zoom, 16 / 9, 1, plane_far - plane_near + 1);

// Store offset values for when the camera is moved by shooting
camera_offset_position = [0, 0, 0];

// Store how strong the draw from the offset position back to the action position is
draw_force = 20;

// Hold how fast the camera is moving
speeds = [0, 0, 0];

// Function to create a movement impulse from shooting
function shot_impulse(hori_mult)
{
	speeds[0] = -15 * hori_mult;
	speeds[1] = -15;
	speeds[2] = -15;
}