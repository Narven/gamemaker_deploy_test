// If the owner doesn't exist any more, destroy this
if(!instance_exists(owner))
{
	instance_destroy();
	exit;
}

// Match the owner's position
x = owner.x + owner.weak_spot_offset[0] * owner.image_xscale;
y = owner.y + owner.weak_spot_offset[1] * owner.image_yscale;

// Move slightly in front of the owner so the weak spot is shot first
depth = owner.depth - 1;