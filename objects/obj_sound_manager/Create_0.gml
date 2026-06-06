/// Sound manager object
// Organises the audio levels as well as the currently playing sounds that are to be tracked

// Levels for all the different types of values 
bgm_level = 1.0;
ui_level = 1.0;
sfx_level = 1.0;

// Variable for storing the currently playing background music audio
current_bgm = -1;

// Variable for storing the currently playing UI audio
current_ui = -1;

// Array for keeping track of stored sound effects
current_sfx = [];

// Background music assets
asset_bgm_splash = snd_bgm_loop_title;
asset_bgm_gameplay = snd_bgm_loop_gameplay;

// Ui sound effect assets
asset_ui_open = snd_ui_menu_open;
asset_ui_close = snd_ui_menu_close;
asset_ui_confirm = snd_ui_button_confirm;
asset_ui_reject = snd_ui_button_fail;

asset_ui_hover = snd_ui_button_hover;

asset_ui_wave_swoosh_1 = snd_ui_wave_swoosh_1;
asset_ui_wave_swoosh_2 = snd_ui_wave_swoosh_2;

// Player sound effects
asset_sfx_player_damage_death = snd_player_damage_death;

asset_sfx_player_damage_hurt_1 = snd_player_damage_react_hurt_1;
asset_sfx_player_damage_hurt_2 = snd_player_damage_react_hurt_2;
asset_sfx_player_damage_hurt_3 = snd_player_damage_react_hurt_3;

asset_sfx_player_weapon_fire_1 = snd_player_weapon_primary_fire_1;
asset_sfx_player_weapon_fire_2 = snd_player_weapon_primary_fire_2;
asset_sfx_player_weapon_fire_3 = snd_player_weapon_primary_fire_3;
asset_sfx_player_weapon_fire_4 = snd_player_weapon_primary_fire_4;
asset_sfx_player_weapon_fire_5 = snd_player_weapon_primary_fire_5;
asset_sfx_player_weapon_fire_6 = snd_player_weapon_primary_fire_6;
asset_sfx_player_weapon_fire_7 = snd_player_weapon_primary_fire_7;
asset_sfx_player_weapon_fire_8 = snd_player_weapon_primary_fire_8;
asset_sfx_player_weapon_fire_9 = snd_player_weapon_primary_fire_9_tail;

asset_sfx_player_weapon_reload = snd_player_weapon_primary_reload;

asset_sfx_player_weapon_empty_1 = snd_player_weapon_primary_bullet_dry_1;
asset_sfx_player_weapon_empty_2 = snd_player_weapon_primary_bullet_dry_2;
asset_sfx_player_weapon_empty_3 = snd_player_weapon_primary_bullet_dry_3;

asset_sfx_bullet_hit_concrete_1 = snd_player_weapon_primary_bullet_hit_concrete_1;
asset_sfx_bullet_hit_concrete_2 = snd_player_weapon_primary_bullet_hit_concrete_2;
asset_sfx_bullet_hit_concrete_3 = snd_player_weapon_primary_bullet_hit_concrete_3;

asset_sfx_bullet_hit_metal_1 = snd_player_weapon_primary_bullet_hit_metal_1;
asset_sfx_bullet_hit_metal_2 = snd_player_weapon_primary_bullet_hit_metal_2;
asset_sfx_bullet_hit_metal_3 = snd_player_weapon_primary_bullet_hit_metal_3;

asset_sfx_bullet_rattle_1 = snd_player_weapon_primary_fire_rattle_1;
asset_sfx_bullet_rattle_2 = snd_player_weapon_primary_fire_rattle_2;
asset_sfx_bullet_rattle_3 = snd_player_weapon_primary_fire_rattle_3;

asset_sfx_bullet_enemy_hit_1 = snd_player_weapon_primary_feedback_hitmarker_enemy_1;
asset_sfx_bullet_enemy_hit_2 = snd_player_weapon_primary_feedback_hitmarker_enemy_2;
asset_sfx_bullet_enemy_hit_3 = snd_player_weapon_primary_feedback_hitmarker_enemy_3;

asset_sfx_player_bullet_drop_1 = snd_player_weapon_primary_bullet_drop_1;
asset_sfx_player_bullet_drop_2 = snd_player_weapon_primary_bullet_drop_2;
asset_sfx_player_bullet_drop_3 = snd_player_weapon_primary_bullet_drop_3;

asset_sfx_player_damage_yell_1 = snd_player_damage_react_yell_1;
asset_sfx_player_damage_yell_2 = snd_player_damage_react_yell_2;
asset_sfx_player_damage_yell_3 = snd_player_damage_react_yell_3;

// Enemy sound effects
asset_sfx_enemy_weapon_1 = snd_enemy_weapon_fire_1;
asset_sfx_enemy_weapon_2 = snd_enemy_weapon_fire_2;
asset_sfx_enemy_weapon_3 = snd_enemy_weapon_fire_3;
asset_sfx_enemy_weapon_4 = snd_enemy_weapon_fire_4;

asset_sfx_enemy_projectile_1 = snd_enemy_projectile_discharge_1;
asset_sfx_enemy_projectile_2 = snd_enemy_projectile_discharge_2;
asset_sfx_enemy_projectile_3 = snd_enemy_projectile_discharge_3;

asset_sfx_enemy_defeated_ground_1 = snd_enemy_defeated_walker_1;
asset_sfx_enemy_defeated_ground_2 = snd_enemy_defeated_walker_2;
asset_sfx_enemy_defeated_ground_3 = snd_enemy_defeated_walker_3;

asset_sfx_enemy_defeated_fly_1 = snd_enemy_defeated_flyer_1;
asset_sfx_enemy_defeated_fly_2 = snd_enemy_defeated_flyer_2;
asset_sfx_enemy_defeated_fly_3 = snd_enemy_defeated_flyer_3;

// Plays the current background music
current_bgm = audio_play_sound(asset_bgm_splash, 100, true, bgm_level);

// Function for adding a sound effect with some modifiers
add_soundeffect = function(_asset, _gain_mod = 1, _pitch_mod = 1)
{
	// Create a new sound effect
	var _new_sound = audio_play_sound(_asset, 10, false, sfx_level * _gain_mod, 0, _pitch_mod);
	
	// Push the sound effect to an existing array
	array_push(current_sfx, _new_sound);
}

// Function for changing all sound effects gain 
set_soundeffects_gain = function(_gain)
{
	// Loops through the sound effects
	for (var _i = 0; _i < array_length(current_sfx); _i++)
	{
		// Sets the sound effects gain to change to chane imediately 
		audio_sound_gain(current_sfx[_i], sfx_level * _gain, 0);
	}
}

// Pauses all the sound effects playing
pause_soundeffects = function()
{
	// Loops through the sound effects
	for (var _i = 0; _i < array_length(current_sfx); _i++)
	{
		// Pause sound effect
		audio_pause_sound(current_sfx[_i]);
	}
}

// Resuming sound effects
play_soundeffects = function()
{
	// Loops through the sound effects
	for (var _i = 0; _i < array_length(current_sfx); _i++)
	{
		// resumes the sound effect playing
		audio_resume_sound(current_sfx[_i]);
	}
}