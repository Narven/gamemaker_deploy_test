// If the game is paused, stop animating and exit the event.
// Otherwise animate as normal
if(global.is_paused)
{
	image_speed = 0;
	exit;
}
else
{
	image_speed = 1;
}

// Inherit the parent event
event_inherited();

// Flying enemies move vertically and horizontally within their depths
x += move_speed[0] * global.timer_delta * 0.000001;
y += move_speed[1] * global.timer_delta * 0.000001;