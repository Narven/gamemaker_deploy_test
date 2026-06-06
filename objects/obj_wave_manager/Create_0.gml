// Array of wave settings that make it easier to alter wave difficulty for balancing
waves = [
// Wave 1
{
max_enemies : 4,
enemy_spawn_cooldown : 4,
enemies_per_spawn : 1,
enabled_enemies : [obj_enemy_walking],
enemy_shot_damage : 3,
enemy_shot_cooldown : 6,
enemies_to_progress : 5
},

// Wave 2
{
max_enemies : 5,
enemy_spawn_cooldown : 3.5,
enemies_per_spawn : 1,
enabled_enemies : [obj_enemy_walking],
enemy_shot_damage : 3,
enemy_shot_cooldown : 5,
enemies_to_progress : 10
},

// Wave 3
{
max_enemies : 6,
enemy_spawn_cooldown : 3,
enemies_per_spawn : 2,
enabled_enemies : [obj_enemy_walking, obj_enemy_flying],
enemy_shot_damage : 5,
enemy_shot_cooldown : 4,
enemies_to_progress : 15
},

// Wave 4
{
max_enemies : 7,
enemy_spawn_cooldown : 2.5,
enemies_per_spawn : 2,
enabled_enemies : [obj_enemy_walking, obj_enemy_flying],
enemy_shot_damage : 5,
enemy_shot_cooldown : 3,
enemies_to_progress : 20
},

// Wave 5
{
max_enemies : 8,
enemy_spawn_cooldown : 2,
enemies_per_spawn : 3,
enabled_enemies : [obj_enemy_walking, obj_enemy_flying],
enemy_shot_damage : 7,
enemy_shot_cooldown : 2,
enemies_to_progress : 25
},
]

// Store a countdown until the next batch of enemies spawn
enemy_spawn_timer = 2;

// Store how many enemies have been destroyed this wave
enemies_destroyed_this_wave = 0;

// Hold the current wave number and the wave structure that defines the current wave
wave_num = 0;
curr_wave = waves[wave_num];

// Countdown to the next wave so there is a small reprieve between waves
new_wave_timer = 2;

// Make a place to store the wave start sequence so no enemies will be spawned while it exists
wave_prompt = undefined;

// Function to move to the next wave
function next_wave()
{
	// Increment the wave number
	wave_num++;
	
	// If the wave number is greater than the number of waves set out in the array, the game is won
	if(wave_num == array_length(waves) + 1)
	{
		// Decrement the wave number again to avoid any potential array index errors
		wave_num--;
		
		// Create a win manager
		if (!instance_exists(obj_win_manager))
		{
			instance_create_layer(0, 0, "Instances", obj_win_manager);
		}
		
		// Return so the rest of the function doesn't fire
		return;
	}
	
	// Create a wave start sequence
	wave_prompt = layer_sequence_create("UI", room_width / 2, room_height / 2, seq_wavecount);
	
	// Find the new wave structure
	curr_wave = waves[wave_num - 1];
	
	// Reset the current wave stats
	enemy_spawn_timer = 2;
	enemies_destroyed_this_wave = 0;
	new_wave_timer = 2;
	
	// Store the current number of points the player has
	obj_game_manager.points_at_last_wave = obj_game_manager.points;
}

// Function to move to a specific wave
function set_wave(new_wave_num)
{
	// Make sure the wave number specified at function call is valid
	if(0 >= wave_num || wave_num >= array_length(waves))
	{
		show_debug_message("Wave not set due to invalid wave number");
		return
	}
	
	// Store the wave number
	wave_num = new_wave_num;
	
	// Create a wave start sequence
	wave_prompt = layer_sequence_create("UI", room_width / 2, room_height / 2, seq_wavecount);
	
	// Find the new wave struct
	curr_wave = waves[wave_num - 1];
	
	// Reset the current wave stats
	enemy_spawn_timer = 2;
	enemies_destroyed_this_wave = 0;
	new_wave_timer = 2;
}

// Move to the first wave
next_wave();