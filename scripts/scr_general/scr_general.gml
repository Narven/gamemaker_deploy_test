// Configuration macros
#macro debug false
#macro godmode false

#macro DEBUG:debug true
#macro GODMODE:godmode true

// Enable font effects
font_enable_effects(fnt_damage_numbers, true, {
	outlineEnable : true,
	outlineDistance : 2,
	outlineColour : c_black,
	outlineAlpha : 1
});

font_enable_effects(fnt_hud, true, {
	outlineEnable : true,
	outlineDistance : 2,
	outlineColour : c_black,
	outlineAlpha : 1
});

font_enable_effects(fnt_ammo, true, {
	glowEnable : true,
	glowStart : 0,
	glowEnd : 16,
	glowColour : c_white,
	glowAlpha : 0.15
});

font_enable_effects(fnt_hp, true, {
	glowEnable : true,
	glowStart : 0,
	glowEnd : 16,
	glowColour : c_white,
	glowAlpha : 0.15
});

// Function to restart the current wave
function restart_wave()
{
	var curr_wave = obj_wave_manager.wave_num;
	var points_at_last_wave = obj_game_manager.points_at_last_wave;
	room_restart();
	obj_wave_manager.set_wave(curr_wave);
	obj_game_manager.points = 100;
	obj_game_manager.points_at_last_wave = 100;
}