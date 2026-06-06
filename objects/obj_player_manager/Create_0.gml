// Set up the default gun to use
gun = { 
	falloff_close: 1000, 
	falloff_far: 2500, 
	falloff_end_percent: 0.8, 
	recoil: 50,	
	accuracy: 0.4,	
	kick: 0.15,		
	cooldown: 0.1,		
	damage: 4
};

// Create a cooldown for firing and track if there was a shot fired this frame
shot_cooldown = 0;
shot_this_frame = false;

last_hit = 0;

smoke_cooldown = 0;

// Create 2 different recoil vectors.
// recoil is where the recoil WANTS to place the crosshairs
// fake_recoil is where the recoil ACTUALLY places the crosshairs and it smoothly moves towards recoil's position
recoil = [0, 0];
fake_recoil = [0, 0];

// Also hold some extra recoil related variables
recoil_amount = 0;
recoil_add = 0.05;
recoil_mult = 1.07;
recoil_sub = 4;
recoil_max = 400;
recoil_angle = pi/6;

// State where in the room the player's firing position is
shoot_point = [room_width / 2, 1100];

// If the player sprite object existed before the player manager, the program would crash
// This is because the player sprite object uses variables from the camera manager in its create event
// ANd the camera manager uses variables from the player manager in its create. The program cannot function
// with this loop, so find the player character later
player_character = undefined;

// Store ammo
ammo_max = 45;
ammo_count = ammo_max;

// Reload variables
wants_to_reload = false;
is_reloading = false;
reload_prompt = undefined;
reload_length = 38 / 60; // 38 frames at 60fps

// HP variables
hp = 100;
max_hp = 100;

// Accuracy variables
accuracy = 1;
accuracy_sub = 1;

// Track whether the player character is currently standing up
standing = false;

// Function to shoot at enemies
function shoot()
{
	// Find a random unit vector that will be scaled by accuracy for where the shot will go
	var t = random_range(-pi, pi);
	var vec = [cos(t), sin(t)];
	
	// Randomly place the shot close to the crosshairs in accordance with the current recoil and how accurate the gun is
	var shot_vec = [0, 0];
	var shot_dist = random(150 * recoil_amount);
	shot_vec[0] = shot_dist * vec[0] * accuracy * gun.accuracy;
	shot_vec[1] = shot_dist * vec[1] * accuracy * gun.accuracy;
	
	// Find where the shot would be going
	var shot_x = obj_input_manager.mouse_point[0] + (fake_recoil[0] + shot_vec[0] / 3) / (1 - obj_camera_manager.zoom * 0.4);
	var shot_y = obj_input_manager.mouse_point[1] + (fake_recoil[1] + shot_vec[1] / 3) / (1 - obj_camera_manager.zoom * 0.4); 
	
	// If the player is using touch controls but the shot wouldn't hit an enemy, don't shoot
	if(obj_input_manager.input_style == input_styles.TOUCH && !obj_enemy_manager.would_shoot_enemy(shot_x, shot_y))
	{
		exit;
	}
	
	// If the configuration is in debug or the gun is still on cooldown, block the firing mechanism
	if(!godmode && shot_cooldown > 0 || !standing || is_reloading || wants_to_reload || ammo_count <= 0 || global.is_paused || global.is_fading)
	{
		if (ammo_count <= 0 && shot_cooldown <= 0 && standing && !global.is_paused && !global.is_fading)
		{
			shot_cooldown = gun.cooldown;
			
			var _sfx = choose(
			obj_sound_manager.asset_sfx_player_weapon_empty_1, 
			obj_sound_manager.asset_sfx_player_weapon_empty_2,
			obj_sound_manager.asset_sfx_player_weapon_empty_3
			);
	
			obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
		}
		
		exit;
	}
	
	var _sfx = choose(
	obj_sound_manager.asset_sfx_player_weapon_fire_1, 
	obj_sound_manager.asset_sfx_player_weapon_fire_2,
	obj_sound_manager.asset_sfx_player_weapon_fire_3,
	obj_sound_manager.asset_sfx_player_weapon_fire_4,
	obj_sound_manager.asset_sfx_player_weapon_fire_5,
	obj_sound_manager.asset_sfx_player_weapon_fire_6,
	obj_sound_manager.asset_sfx_player_weapon_fire_7,
	obj_sound_manager.asset_sfx_player_weapon_fire_8,
	obj_sound_manager.asset_sfx_player_weapon_fire_9
	);
	
	obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
	
	// Create a camera impulse to give the shooting weight
	obj_camera_manager.shot_impulse((get_mouse_x_real() - room_width / 2) / 500);
	
	obj_camera_manager.target_zoom += 0.05;
	
	obj_camera_manager.target_zoom = clamp(obj_camera_manager.target_zoom, 0.0, 1.0);
	
	obj_vignette_manager.effect_strength -= 0.05;
	obj_vignette_manager.shot_cooldown += 0.05;
	
	var _x = player_character.x + 168;
	var _y = player_character.y - 380;
	
	var _dir = point_direction(_x, _y, get_mouse_x_real(), get_mouse_y_real()) - 90;
	
	var _muzzle_flash = instance_create_layer(_x, _y, "Character", obj_particle_manager);
	_muzzle_flash.create_ps(ps_player_muzzle_flash, "Character", -1, true, false);
	_muzzle_flash.set_render_scale(true, 0.35);
	
	smoke_cooldown = 0.15;
	
	// Put the shot on cooldown and state that the gun was fired this frame
	shot_cooldown = gun.cooldown;
	shot_this_frame = true;
	
	ammo_count--;
	
	if (ammo_count < ammo_max * 0.25)
	{
		var _new_sfx = choose(
		obj_sound_manager.asset_sfx_bullet_rattle_1, 
		obj_sound_manager.asset_sfx_bullet_rattle_2,
		obj_sound_manager.asset_sfx_bullet_rattle_3
		);
	
		obj_sound_manager.add_soundeffect(_new_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));	
	}
	
	// Check with the enemy manager if any enemies were actually shot
	obj_enemy_manager.shoot_at(
		shot_x,
		shot_y,
		gun
	);
	
	// Find the inverse matrices of the camera
	var _matrixViewProj = matrix_multiply(obj_camera_manager.view_mat, obj_camera_manager.proj_mat);
	var _matrixViewProjInv = matrix_inverse(_matrixViewProj);
	
	// Find where the shot vector intersects the muzzle flash layer so the shot is accurate between the flash and where the shot actually went in the room
	var _point = screen_to_plane_3d(
	obj_input_manager.mouse_point[0] + fake_recoil[0] + shot_vec[0],
	obj_input_manager.mouse_point[1] + fake_recoil[1] + shot_vec[1],
	[0, 0, layer_get_depth("Muzzle_Flashes")],
	[0, 0, -1],
	_matrixViewProjInv
	);
	
	// Apply recoil be creating a random vector the points more upwards on the screen than it does any other direction
	t = random_range(-recoil_angle, recoil_angle);
	rot_mat = [
		[cos(t), -sin(t)],
		[sin(t), cos(t)]
	]
	
	vec = [0, -1];
	
	var recoil_vec = [
		vec[0] * rot_mat[0][0] + vec[1] * rot_mat[1][0],
		vec[0] * rot_mat[0][1] + vec[1] * rot_mat[1][1]
	]
	
	// Increase the amount that recoil should affect the gun due to continuous firing but limit it
	recoil_amount += recoil_add;
	recoil_amount *= recoil_mult;
	recoil_amount = min(recoil_amount, 2);
	
	// Increase the hidden recoil by the random vector multiplied by the amount continuous firing affects it, and the amount of recoil the gun has
	recoil[0] += recoil_vec[0] * gun.recoil * recoil_amount;
	recoil[1] += recoil_vec[1] * gun.recoil * recoil_amount;
	
	// Limit the upper limit of the recoil so it doesn't become completely uncontrollable
	recoil[1] = max(-recoil_max, recoil[1]);
	
	// Make sure the recoil stays in the generally upwards direction
	// Do this by finding the closest vector within the range specified that has the same upwards scale
	var dir = degtorad(point_direction(0, 0, recoil[0], recoil[1]));
	if(dir <= pi/2 - recoil_angle || dir >= pi/2 + recoil_angle)
	{
		var y_pos = recoil[1];
		
		t = (dir < pi/2) ? -recoil_angle : recoil_angle;
		rot_mat = [
			[cos(t), -sin(t)],
			[sin(t), cos(t)]
		]
		
		recoil[0] = vec[0] * rot_mat[0][0] + vec[1] * rot_mat[1][0];
		recoil[1] = vec[0] * rot_mat[0][1] + vec[1] * rot_mat[1][1];
		
		var lambda = y_pos / recoil[1];
		
		recoil[0] *= lambda;
		recoil[1] *= lambda;
	}
	
	// Increase the accuracy tracker (which actually decreases the accuracy of shots) but limit it
	accuracy = min(2, accuracy + gun.kick);
	
	obj_player_sprite.shoot();
}

function take_damage(damage)
{
	obj_player_sprite.swap_anim(["Stand", "Hurt"]);
	
	hp -= damage;
	
	var _shocks = instance_create_depth(obj_player_sprite.x + 105, obj_player_sprite.y + 105, obj_player_sprite.depth - 1, obj_particle_manager);
	var _shocks_layer = layer_create(obj_player_sprite.depth - 1, string(_shocks.id) + string(current_time));
	_shocks.create_ps(ps_electrical_player_damage_full, _shocks_layer, -1, true, false);
	_shocks.set_render_scale(true, 0.235);
	_shocks.is_layer_cleaned = true;
	
	if(hp < 0) hp = 0;
	
	if(hp <= 0)
	{
		obj_sound_manager.add_soundeffect(obj_sound_manager.asset_sfx_player_damage_death);
        
		if (!instance_exists(obj_lose_manager))
		{
			instance_create_layer(0, 0, "Instances", obj_lose_manager);	
		}
	}
	else
	{
		var _sfx = choose(
		obj_sound_manager.asset_sfx_player_damage_hurt_1, 
		obj_sound_manager.asset_sfx_player_damage_hurt_2,
		obj_sound_manager.asset_sfx_player_damage_hurt_3,
		obj_sound_manager.asset_sfx_player_damage_yell_1,
		obj_sound_manager.asset_sfx_player_damage_yell_2,
		obj_sound_manager.asset_sfx_player_damage_yell_3
		);
	
		obj_sound_manager.add_soundeffect(_sfx, random_range(0.7, 1.0), random_range(0.95, 1.05));
	}
}