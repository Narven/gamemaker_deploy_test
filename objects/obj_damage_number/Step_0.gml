// Increment the timer by 4 times the time between frames
// This is so that the timer reaches 1 at 0.25 seconds after it was created but still
// has the timer go from 0 to 1 for use in calculations
timer += 4 * global.timer_delta * 0.000001;

if(timer >= 1)
{
	instance_destroy();
	exit;
}

// Reposition and rescale according to the timer
y = ystart - 200 * timer;
image_alpha = 1 - timer;
image_xscale = 1 + image_alpha * 2;
image_yscale = 1 + image_alpha * 2;