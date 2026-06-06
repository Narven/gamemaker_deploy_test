// Set the level of max zoom based on how high in the room the mouse is so further away objects are larger when aimed at
var _default_zoom = (room_height - get_mouse_y_real()) * (1 / room_height) * 0.45; 
target_zoom = lerp(target_zoom, _default_zoom, 0.15);

if (global.zoom_enabled) // If the camera should be zoomed in, lerp zoom towards the target zoom
{
	zoom = lerp(zoom, target_zoom, 0.3);
}
else // Otherwise lerp back towards zero
{
	zoom = lerp(zoom, 0, 0.3);	
}

// Draw the camera offset back to zero
// Find the inverse of the offset vector and its length
var vec = [-camera_offset_position[0], -camera_offset_position[1], -camera_offset_position[2]];
var dist = point_distance_3d(0, 0, 0, camera_offset_position[0], camera_offset_position[1], camera_offset_position[2]);

// If the distance is not equal to zero, apply an offset to the speeds proportional to the distance
// Distance can't be zero the inverse vector is normalised and dividing by zero crashes computers
if(dist != 0)
{
	var speed_add = draw_force * dist / 20;
	
	vec[0] /= dist;
	vec[1] /= dist;
	vec[2] /= dist;

	speeds[0] += speed_add * vec[0];
	speeds[1] += speed_add * vec[1];
	speeds[2] += speed_add * vec[2];
}

// Apply the speeds to the camera offset
camera_offset_position[0] += speeds[0] * global.update_time;
camera_offset_position[1] += speeds[1] * global.update_time;
camera_offset_position[2] += speeds[2] * global.update_time;

// Reduce the speeds a bit to simulate drag
speeds[0] *= 0.85;
speeds[1] *= 0.85;
speeds[2] *= 0.85;