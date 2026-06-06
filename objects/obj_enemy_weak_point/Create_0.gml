// Match the owner's state
curr_state = owner.curr_state;

// Scale up to match the owning enemy at 160% my original scale
image_xscale *= 1.6;
image_xscale *= owner.image_xscale;
image_yscale = image_xscale;

// A weak point's only functionality is to transfer damage to its owner at scaled rate
function take_damage(damage, virtual_for_polymorphism)
{	
	owner.take_damage(damage * weakness_mult, true);
}