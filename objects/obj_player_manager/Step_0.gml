if(global.is_paused)
{
	exit;
}

var _touch_bypass = false;

if (instance_exists(obj_hud_touch_reload))
{
    if (obj_hud_touch_reload.is_pressed)
    {
        _touch_bypass = true;  
    }
}

if ((keyboard_check_pressed(ord("R")) || _touch_bypass) && ammo_count < ammo_max && !is_reloading)
{
	wants_to_reload = true;
}

// Move the displayed recoil smoothly towards the desired position
fake_recoil[0] = lerp(fake_recoil[0], recoil[0], 0.5);
fake_recoil[1] = lerp(fake_recoil[1], recoil[1], 0.5);

// If the gun was not shot this frame, decrease the cooldown, otherwise just reset the flag
if(!shot_this_frame) shot_cooldown = max(0, shot_cooldown - global.timer_delta * 0.000001);
else shot_this_frame = false;

if (last_hit > 0)
{
	last_hit -= global.update_time * 2;	
}

// Calculate zoome
obj_camera_manager.zoom = lerp(obj_camera_manager.zoom, 0, 0.5);
if(!mouse_check_button(mb_left))
{
	recoil_amount = max(0, recoil_amount - recoil_sub * global.timer_delta * 0.000001);
}

// Decrease the current recoil by finding a slightly shorter version of the offset vector
var dist = max(1, point_distance(0, 0, recoil[0], recoil[1]));
var unit_vec = [recoil[0] / dist, recoil[1] / dist];
var new_dist = max(0, dist * 0.95);
recoil = [unit_vec[0] * new_dist, unit_vec[1] * new_dist];

// Also restore accuracy back towards 1
accuracy = max(1, accuracy - accuracy_sub * global.timer_delta * 0.000001);

// If the player's shooting point is currently above the top of the barricade, they are standing. Otherwise they are not.
// Find the inverse matrices of the camera
var _matrixViewProj = matrix_multiply(obj_camera_manager.view_mat, obj_camera_manager.proj_mat);
var _matrixViewProjInv = matrix_inverse(_matrixViewProj);
	
// Find where the shot vector intersects the muzzle flash layer so the shot is accurate between the flash and where the shot actually went in the room
var point = screen_to_plane_3d(
	obj_input_manager.mouse_point[0] + fake_recoil[0],
	obj_input_manager.mouse_point[1] + fake_recoil[1],
	[0, 0, layer_get_depth("Stage_Front")],
	[0, 0, -1],
	_matrixViewProjInv
);

// Calculate whether the player character is standing
if(point != undefined && !wants_to_reload && !is_reloading)
{
	standing = (point[1] <= room_height / 2 + 459 * (layer_get_depth("Stage_Front") - obj_camera_manager.plane_near) / 4000);
}
else
{
	standing = false;
}

// Find the player character
player_character ??= instance_find(obj_player_sprite, 0);

// If the player wants to reload and they can, do so
if(player_character.can_reload() && wants_to_reload)
{
	recoil_amount = 0;
	is_reloading = true;
	wants_to_reload = false;
	player_character.start_reload();
		
	obj_sound_manager.add_soundeffect(obj_sound_manager.asset_sfx_player_weapon_reload, random_range(0.7, 1.0), random_range(0.95, 1.05));
		
	for (var _i = 0; _i < ammo_count; _i += 20)
	{
		var _sfx = choose(
			obj_sound_manager.asset_sfx_player_bullet_drop_1,
			obj_sound_manager.asset_sfx_player_bullet_drop_2,
			obj_sound_manager.asset_sfx_player_bullet_drop_3
		);
			
		obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
	}
}
	
// If the player isn't reloading and there is a mismatch between the manager wanting the player
// to stand and what the sprite object is showing, make the character turn around
if(!is_reloading && (standing ^^ player_character.is_standing))
{
	player_character.turn();
}

// Create a particle effect for a smoking gun barrel once the timer runs out so it doesn't appear while firing
if (smoke_cooldown > 0)
{
	smoke_cooldown -= global.update_time;
	
	if (smoke_cooldown <= 0)
	{
		var _smoke_vfx = instance_create_depth(obj_player_sprite.x + 170, obj_player_sprite.y - 400, layer_get_depth("Character") + 1, obj_particle_manager);
		var _smoke_layer = layer_create(depth + 1, string(_smoke_vfx.id) + string(current_time));
		_smoke_vfx.create_ps(ps_smoke_gun, _smoke_layer, -1, true, false);
		_smoke_vfx.is_layer_cleaned = true;
		_smoke_vfx.set_render_scale(true, 0.3);
	}
}

// If the player is out of ammo but no prompt for them to reload exists yet, create one
if(ammo_count == 0 && reload_prompt == undefined)
{
	reload_prompt = layer_sequence_create("Instances", room_width / 2 - 50, room_height / 2 + 190, seq_reload_icon);
}
else if (reload_prompt != undefined && is_reloading) // Otherwise if one does but the player is reloading, destroy it
{
	layer_sequence_destroy(reload_prompt);
	reload_prompt = undefined;
}