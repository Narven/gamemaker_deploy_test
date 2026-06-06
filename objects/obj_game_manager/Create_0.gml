// Random seed
randomise();

// Set game state
enum game_state { STARTING, PLAYING, PAUSED}
global.curr_game_state = game_state.STARTING;

// Track how much time passes in the different states of play
state_timer = 0;

global.depth_cutoff = -2100;
global.depth_cutoff_enemies = 2600;
global.projectile_speed = 1.025;

global.zoom_enabled = false;

if (!variable_global_exists("damage_ui"))
{
	global.damage_ui = true;
}

// Create the needed environment particle systems
var _effect = -1;

_effect = instance_create_layer(403, 275, "Farground_Effects", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_bg, "Farground_Effects", _effect, true, true);
_effect.set_render_scale(true);

_effect = instance_create_layer(1987, 1187, "Midground_Effects", obj_particle_manager);
_effect.create_ps(ps_fog_bg_additive, "Midground_Effects", _effect, true, true);
_effect.set_render_scale(true);

_effect = instance_create_layer(40, 1298, "Stage_Far_Effects", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_fg, "Stage_Far_Effects", _effect, true, true);
_effect.set_render_scale(true);

_effect = instance_create_layer(2819, 932, "Stage_Far_Effects", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_fg, "Stage_Far_Effects", _effect, true, true);
_effect.set_render_scale(true);

_effect = instance_create_layer(3442, 1401, "Stage_Far_Effects", obj_particle_manager);
_effect.create_ps(ps_smoke_plume_fg, "Stage_Far_Effects", _effect, true, true);
_effect.set_render_scale(true);

_effect = instance_create_layer(1916, 1251, "Stage_Floor", obj_particle_manager);
_effect.create_ps(ps_fog_fg, "Stage_Far_Effects", _effect, true, true);
_effect.set_render_scale(true);

_effect = instance_create_layer(1915, 1281, "Stage_Floor_Effects", obj_particle_manager);
_effect.create_ps(ps_debris_fg, "Stage_Floor_Effects", _effect, true, true);

// Resize and move sprites on asset layers to keep in line with how they're laid out in the room
// If this were not done, the perspective projection would make the assets that are "further away"
// look smaller so this makes them larger.
var layers = layer_get_all();
var depth_mod = 4000;

for(var i = 0; i < array_length(layers); i++)
{	
	if (layer_get_visible(layers[i]))
	{
		var d_depth = layer_get_depth(layers[i]) - obj_camera_manager.plane_near;
		var elements = layer_get_all_elements(layers[i]);
	
		for(var j = 0; j < array_length(elements); j++)
		{	
			if(layer_get_element_type(elements[j]) == layerelementtype_sprite)
			{	
				var x_off = layer_sprite_get_x(elements[j]) - room_width / 2;
				var y_off = layer_sprite_get_y(elements[j]) - room_height / 2;
			
				layer_sprite_x(elements[j], room_width / 2 + x_off * (d_depth / depth_mod));
				layer_sprite_y(elements[j], room_height / 2 + y_off * (d_depth / depth_mod));
			
				layer_sprite_xscale(elements[j], layer_sprite_get_xscale(elements[j]) * d_depth / depth_mod);
				layer_sprite_yscale(elements[j], layer_sprite_get_yscale(elements[j]) * d_depth / depth_mod);
			}
		
			if (layer_get_element_type(elements[j]) == layerelementtype_instance)
			{	
				var _inst = layer_instance_get_instance(elements[j]);
			
				if (_inst.object_index == obj_particle_manager)
				{
					var x_off = _inst.x - room_width / 2;
					var y_off = _inst.y - room_height / 2;
				
					_inst.x = room_width / 2 + x_off * (d_depth / depth_mod);
					_inst.y = room_height / 2 + y_off * (d_depth / depth_mod);
				
					_inst.render_scale = d_depth / depth_mod;
				
					_inst.simulate_effect(3);
				}
			}
		}
	}
}

// Store a reference to the sound manager's asset_ui_open SFX so buttons can't make sound while it exists
button_pressed_sfx = obj_sound_manager.asset_ui_open;

// Function to play a button sound if one is not already playing
play_button_sound = function()
{
	if (button_pressed_sfx != -1)
	{
		if (obj_sound_manager.current_ui != -1 && audio_is_playing(obj_sound_manager.current_ui))
		{
			audio_sound_gain(obj_sound_manager.current_ui, 0, 100);
			obj_sound_manager.current_ui = -1;
		}
		
		obj_sound_manager.current_ui = audio_play_sound(button_pressed_sfx, 100, false, obj_sound_manager.ui_level, 0.05);
	}
}

// Store the current amount of points the player has and the amount they had at the end of the last wave
points = 0;
points_at_last_wave = 100;

// Store a timer for the HP and ammo warning flashes so they're in sync
warning_flash_timer = 0;