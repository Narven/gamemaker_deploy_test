// Inherit the parent event
event_inherited();

if (instance_exists(obj_effect_overlay))
{
	image_alpha = 1 - obj_effect_overlay.blocker_alpha;
}

// Sets the particle systems colour to white at the set alpha
part_system_color(particle_sys, c_white, image_alpha);