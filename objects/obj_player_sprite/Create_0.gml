// Store the current animation the sprite is using
curr_anim_path = ["Cover", "Idle 1", "Regular"];
current_animation = find_animation(curr_anim_path, global.player_animations);

sprite_index = current_animation.sprite;
skeleton_animation_set_ext(current_animation.anim_name, 0, false);

// Flags for turning the player around from standing to crouching
turning = false;
wants_to_turn = false;

// Hold the game FPS
current_animation_fps = 60;

// Flags for describing the sprite's current state
is_standing = false;
is_reloading = false;

// Track how long the player has been reloading for
reload_time = 0;

// Scale based on distance from the camera
var d_depth = depth - obj_camera_manager.plane_near;
var depth_mod = 4000;

var x_off = x - room_width / 2;
var y_off = y - room_height / 2;

x = room_width / 2 + x_off * d_depth / depth_mod;
y = room_height / 2 + y_off * d_depth / depth_mod;

image_xscale *= d_depth / depth_mod;
image_yscale *= d_depth / depth_mod;

// Function to initiate a turn
function turn()
{
	wants_to_turn = true;
}

// Function to change between animations easily
function swap_anim(path)
{
	curr_anim_path = path;
	current_animation = find_animation(curr_anim_path, global.player_animations);

	sprite_index = current_animation.sprite;
	skeleton_animation_set_ext(current_animation.anim_name, 0, false);
}

// Function to swap to the shooting animation specifically
function shoot()
{
	swap_anim(["Stand", "Shoot"]);
}

// Function to more easily find whether the player is doing anything that would stop them from reloading
function can_reload()
{
	return !is_standing && !turning && !is_reloading;
}

// Function to initiate a reload
function start_reload()
{
	swap_anim(["Cover", "Reload"]);
	is_reloading = true;
	
	image_speed = 1;
	reload_time = 0;
}

// Function to see how far through the reload animation the sprite is
function get_reload_progress()
{
	if(is_reloading)
	{
		return skeleton_animation_get_position(0);
	}
	else
	{
		return 0;
	}
}

// Function to complete the reload, completing the magazine swap
function finish_reload()
{
	with(obj_player_manager)
	{
		ammo_count = ammo_max;
		is_reloading = false;
	}
	
	is_reloading = false;
	obj_hud_ammo.fake_mag_point = 1;
	
	image_speed = 1;
}