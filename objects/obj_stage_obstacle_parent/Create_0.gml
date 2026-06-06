// Find the obstacle's position on the floor plane based on its position in the room
var x_percentage = x / room_width - 0.5;
var y_percentage = (y - 1270)/(room_height-1270);

// Project the obstacle onto the floor plane
x = room_width / 2 + x_percentage * (room_width / 4 + (1 - y_percentage) * room_width*3);
y = room_height * 3/4 + y_percentage * (room_height * 1/4)
depth = layer_get_depth("Character") + 8500 * (1 - y_percentage);

// Scale up the obstacle a bit for visibility
image_xscale *= 1.5;
image_yscale *= 1.5;