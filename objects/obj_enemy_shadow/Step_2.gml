// If the related enemy doesn't exist any more, destroy this shadow
if(!instance_exists(owner))
{
	instance_destroy();
	exit;
}

// Match the shadow's owner's position projected onto the ground
x = owner.x;
y = 1620 + 540 * (1 - (owner.depth + 4000) / 8500) - 25;
depth = owner.depth + 1;

// Set scale and alpha to be proportional to the distance from the owning enemy to the ground
image_xscale = max(0, (3000 - abs(owner.y - y)) / 3000) * 1.7;
image_yscale = image_xscale;
image_alpha = image_xscale * 2;