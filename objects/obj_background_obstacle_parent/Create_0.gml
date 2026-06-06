// Move away from the centre of the room in accordance with the room's scaling due to the camera's perspective projection
// Find how far from the camera the obstacle is
var d_depth = depth - obj_camera_manager.plane_near;

// Find the obstacle's relative position from the centre of the room
var x_off = x - room_width / 2;
var y_off = y - room_height / 2;

// Alter the obstacle's relative position based on the depth from the camera
var depth_mod = 4000;
x = room_width / 2 + x_off * (d_depth / depth_mod);
y = room_height / 2 + y_off * (d_depth / depth_mod);

// Scale up by the same amount
image_xscale *= d_depth / depth_mod;
image_yscale *= d_depth / depth_mod;