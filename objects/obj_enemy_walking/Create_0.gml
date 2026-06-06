// Inherit the parent event
event_inherited();

// Set the default animation tree variables
default_anim = global.enemy_animations.Walker.Normal.Idle;
anim_tree = "Walker";

// Hold space to store particle effects for steps and a flag to show if VFX has been made for this frame index
has_step = false;
prev_index = 0;

// Create a starting x point off screen where this enemy can walk in from
var start_x_point = 1800 + 1700 * depth_mod;

// If the enemy spawned on the left side of the room, have it walk in from the left.
// Do the opposite if it spawned on the right side
if(x < room_width / 2)
{
	x = -start_x_point
	next_move_dir = "Right";
}
else
{
	x = room_width + start_x_point;
	next_move_dir = "Left";
}

// Have the enemy walk back to where it spawned
end_move_dist = abs(xstart - x);

// Trigger an animation change to make it start walking
trigger_animation_change = true;
next_anim = [anim_tree, is_damaged ? "Damage" : "Normal", "Move", next_move_dir];

// Create a shadow for this enemy
instance_create_depth(x, y, depth + 1, obj_enemy_shadow, {owner: id});

// Create an offset for spark VFX when the enemy is damaged
spark_offset = [9, -255];

// If the enemy was instantiated to have a weak spot, create one and link it to this enemy
if(has_weak_spot)
{
	weak_spot = instance_create_depth(x + weak_spot_offset[0] * image_xscale, y + weak_spot_offset[1] * image_yscale, depth - 1, obj_enemy_weak_point, {owner : id});
}