recoil_view = dbg_view("Recoil", true, 100, 300);

dbg_section("Recoil");

dbg_slider(ref_create(ref_create(instance_find(obj_player_manager, 0), "gun"), "recoil"), 0, 200, "Gun Recoil");
dbg_slider(ref_create(ref_create(instance_find(obj_player_manager, 0), "gun"), "kick"), 0, 3, "Gun Kick");
dbg_slider(ref_create(ref_create(instance_find(obj_player_manager, 0), "gun"), "accuracy"), 0, 5, "Gun Accuracy");

dbg_slider(ref_create(instance_find(obj_player_manager, 0), "recoil_angle"), 0, pi, "Recoil Angle");
dbg_slider(ref_create(instance_find(obj_player_manager, 0), "recoil_add"), 0, 2, "Recoil Add");
dbg_slider(ref_create(instance_find(obj_player_manager, 0), "recoil_mult"), 0, 2, "Recoil Multiplier");
dbg_slider(ref_create(instance_find(obj_player_manager, 0), "recoil_sub"), 0, 10, "Recoil Return");
dbg_slider(ref_create(instance_find(obj_player_manager, 0), "recoil_max"), 0, 1000, "Recoil Max");

balance_view = dbg_view("Balance", true, 100, 300);

dbg_section("Player");

dbg_slider(ref_create(instance_find(obj_player_manager, 0), "ammo_count"), 0, 200, "Current ammo", 1);
dbg_slider(ref_create(instance_find(obj_player_manager, 0), "ammo_max"), 0, 200, "Max ammo", 1);
dbg_slider(ref_create(instance_find(obj_player_manager, 0), "hp"), 0, 200, "Current HP");
dbg_slider(ref_create(instance_find(obj_player_manager, 0), "max_hp"), 0, 200, "Max HP", 1);

dbg_slider(ref_create(instance_find(obj_player_manager, 0), "reload_length"), 0, 10, "Reload time");

dbg_section("Enemies");

dbg_slider(ref_create(global, "projectile_speed"), 0, 5, "Projectile speed");

dbg_slider(ref_create(global, "depth_cutoff"), -16000, 16000, "Effect depth cutoff", 50);

dbg_slider(ref_create(global, "depth_cutoff_enemies"), -16000, 16000, "Effect depth cutoff enemy", 50);

dbg_section("Waves");

dbg_slider(ref_create(instance_find(obj_wave_manager, 0), "wave_num"), 0, 5, "Current wave", 1);
dbg_slider(ref_create(instance_find(obj_wave_manager, 0), "enemies_destroyed_this_wave"), 0, 200, "Enemies killed this wave", 1);

dbg_slider(ref_create(ref_create(instance_find(obj_wave_manager, 0), "curr_wave"), "max_enemies"), 0, 50, "Max on screen enemies", 1);
dbg_slider(ref_create(ref_create(instance_find(obj_wave_manager, 0), "curr_wave"), "enemy_spawn_cooldown"), 0, 50, "Enemy spawn cooldown");
dbg_slider(ref_create(ref_create(instance_find(obj_wave_manager, 0), "curr_wave"), "enemies_per_spawn"), 0, 50, "Enemies per spawn", 1);
dbg_slider(ref_create(ref_create(instance_find(obj_wave_manager, 0), "curr_wave"), "enemy_shot_damage"), 0, 1000, "Enemy shot damage");
dbg_slider(ref_create(ref_create(instance_find(obj_wave_manager, 0), "curr_wave"), "enemy_shot_cooldown"), 0, 1000, "Enemy shot cooldown");
dbg_slider(ref_create(ref_create(instance_find(obj_wave_manager, 0), "curr_wave"), "enemies_to_progress"), 0, 200, "Enemies to progress", 1);

button_02 = function()
{
	with (obj_enemy_parent)
	{
		explode()
	}
	
	obj_wave_manager.wave_num -= 1;
	
	obj_wave_manager.wave_num = max(obj_wave_manager.wave_num, 0);
	
	obj_wave_manager.enemies_destroyed_this_wave = obj_wave_manager.curr_wave.enemies_to_progress;
}
dbg_button("Restart Wave", ref_create(self, "button_02"), 240, 30);

button_01 = function()
{
	with (obj_enemy_parent)
	{
		explode()
	}
	
	obj_wave_manager.enemies_destroyed_this_wave = obj_wave_manager.curr_wave.enemies_to_progress;
}
dbg_button("End Wave", ref_create(self, "button_01"), 240, 30);

dbg_section("Player");

dbg_section("Player");

show_debug_overlay(false)