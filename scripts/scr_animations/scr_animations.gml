// All directions enemies can move
enum enemy_directions { LEFT, RIGHT, UP, DOWN, FRONT, BACK }

// All enemy animations
global.enemy_animations = {
	"Flyer" : {
		"Damage" : {
			"Idle" :
			{
				in : undefined,
				during : spr_enemy_flyer_damage_idle,
				out : undefined,
				after : ["Flyer", "Damage", "Idle"],
				can_loop : true,
			},
			"Move" : {
				"Up" :
				{
					in : spr_enemy_flyer_damage_up_in,
					during : spr_enemy_flyer_damage_up_idle,
					out : spr_enemy_flyer_damage_up_out,
					after : ["Flyer", "Damage", "Idle"],
					can_loop : true,
				},
				"Down" :
				{
					in : spr_enemy_flyer_damage_down_in,
					during : spr_enemy_flyer_damage_down_idle,
					out : spr_enemy_flyer_damage_down_out,
					after : ["Flyer", "Damage", "Idle"],
					can_loop : true,
				},
				"Left" :
				{
					in : spr_enemy_flyer_damage_left_in,
					during : spr_enemy_flyer_damage_left_idle,
					out : spr_enemy_flyer_damage_left_out,
					after : ["Flyer", "Damage", "Idle"],
					can_loop : true,
				},
				"Right" :
				{
					in : spr_enemy_flyer_damage_right_in,
					during : spr_enemy_flyer_damage_right_idle,
					out : spr_enemy_flyer_damage_right_out,
					after : ["Flyer", "Damage", "Idle"],
					can_loop : true,
				},
			}
		},
		"Normal" : {
			"Idle" :
			{
				in : undefined,
				during : spr_enemy_flyer_normal_idle,
				out : undefined,
				after : ["Flyer", "Normal", "Idle"],
				can_loop : true,
			},
			"Move" : {
				"Up" :
				{
					in : spr_enemy_flyer_normal_up_in,
					during : spr_enemy_flyer_normal_up_idle,
					out : spr_enemy_flyer_normal_up_out,
					after : ["Flyer", "Normal", "Idle"],
					can_loop : true,
				},
				"Down" :
				{
					in : spr_enemy_flyer_normal_down_in,
					during : spr_enemy_flyer_normal_down_idle,
					out : spr_enemy_flyer_normal_down_out,
					after : ["Flyer", "Normal", "Idle"],
					can_loop : true,
				},
				"Left" :
				{
					in : spr_enemy_flyer_normal_left_in,
					during : spr_enemy_flyer_normal_left_idle,
					out : spr_enemy_flyer_normal_left_out,
					after : ["Flyer", "Normal", "Idle"],
					can_loop : true,
				},
				"Right" :
				{
					in : spr_enemy_flyer_normal_right_in,
					during : spr_enemy_flyer_normal_right_idle,
					out : spr_enemy_flyer_normal_right_out,
					after : ["Flyer", "Normal", "Idle"],
					can_loop : true,
				},
			}
		}
	},
	"Walker" : {
		"Damage" : {
			"Idle" :
			{
				in : undefined,
				during : spr_enemy_walk_damage_idle,
				out : undefined,
				after : ["Walker", "Damage", "Idle"],
				can_loop : true,
			},
			"Move" : {
				"Up" :
				{
					in : undefined,
					during : spr_enemy_walk_damage_back_full,
					out : undefined,
					after : ["Walker", "Damage", "Idle"],
					can_loop : true,
				},
				"Down" :
				{
					in : undefined,
					during : spr_enemy_walk_damage_front_full,
					out : undefined,
					after : ["Walker", "Damage", "Idle"],
					can_loop : true,
				},
				"Left" :
				{
					in : undefined,
					during : spr_enemy_walk_damage_left_full,
					out : undefined,
					after : ["Walker", "Damage", "Idle"],
					can_loop : true,
				},
				"Right" :
				{
					in : undefined,
					during : spr_enemy_walk_damage_right_full,
					out : undefined,
					after : ["Walker", "Damage", "Idle"],
					can_loop : true,
				},
			}
		},
		"Normal" : {
			"Idle" :
			{
				in : undefined,
				during : spr_enemy_walk_normal_idle,
				out : undefined,
				after : ["Walker", "Normal", "Idle"],
				can_loop : true,
			},
			"Move" : {
				"Up" :
				{
					in : undefined,
					during : spr_enemy_walk_normal_back_full,
					out : undefined,
					after : ["Walker", "Normal", "Idle"],
					can_loop : true,
				},
				"Down" :
				{
					in : undefined,
					during : spr_enemy_walk_normal_front_full,
					out : undefined,
					after : ["Walker", "Normal", "Idle"],
					can_loop : true,
				},
				"Left" :
				{
					in : undefined,
					during : spr_enemy_walk_normal_left_full,
					out : undefined,
					after : ["Walker", "Normal", "Idle"],
					can_loop : true,
				},
				"Right" :
				{
					in : undefined,
					during : spr_enemy_walk_normal_right_full,
					out : undefined,
					after : ["Walker", "Normal", "Idle"],
					can_loop : true,
				},
			}
		}
	}
}

// All player animations
global.player_animations = {
	"Cover" : {
		"Idle 1" : {
			"Regular" : {
				sprite : spr_player,
				anim_name : "Player_Cover_Idle_1",
				after : [ {
					path : ["Cover", "Idle 1", "Regular"],
					chance : 0.75
				}, {
					path : ["Cover", "Idle 1", "Blink"],
					chance : 0.2
				}, {
					path : ["Cover", "Idle 2"],
					chance : 0.05
				} ]
			},
			"Blink" : {
				sprite : spr_player,
				anim_name : "Player_Cover_Idle_1_Blink",
				after : [ {
					path : ["Cover", "Idle 1", "Regular"],
					chance : 0.95
				}, {
					path : ["Cover", "Idle 2"],
					chance : 0.05
				} ]
			}
		},
		"Idle 2" : {
			sprite : spr_player,
			anim_name : "Player_Cover_Idle_2",
			after : [ {
				path : ["Cover", "Idle 1", "Regular"],
				chance : 0.95
			}, {
				path : ["Cover", "Idle 1", "Blink"],
				chance : 0.05
			} ]
		},
		"Reload" : {
			sprite : spr_player,
			anim_name : "Player_Reload",
			after : [ {
				path : ["Cover", "Idle 1", "Regular"],
				chance : 1
			} ]
		},
		"Turn" : {
			sprite : spr_player,
			anim_name : "Player_Turn_Aim",
			after : [ {
				path : ["Stand", "Idle"],
				chance : 1
			} ]
		}
	},
	"Stand" : {
		"Idle" : {
			sprite : spr_player,
			anim_name : "Player_Aim_Idle",
			after : [ {
				path : ["Stand", "Idle"],
				chance : 1
			} ]
		},
		"Turn" : {
			sprite : spr_player,
			anim_name : "Player_Turn_Cover",
			after : [ {
				path : ["Cover", "Idle 1", "Regular"],
				chance : 1
			} ]
		},
		"Shoot" : {
			sprite : spr_player,
			anim_name : "Player_Aim_Shoot",
			after: [{
				path : ["Stand", "Idle"],
				chance : 1
			} ]
		},
		"Hurt" : {
			sprite : spr_player,
			anim_name : "Player_Aim_Hit",
			after: [{
				path : ["Stand", "Idle"],
				chance : 1
			} ]
		}
	}
}

// Function to find an animation within an animation tree
function find_animation(key, anim_tree)
{
	// Store how many layers deep the animation tree has been searched
	var i = 0;
	
	// Hold the entire animation tree as the animation structure so it can be searched more easily
	var next_anim = anim_tree;
	
	// Search the animation tree at each layer to make sure the next part of the path exists
	// If it doesn't exist then the key is invalid so stop
	while(i != array_length(key))
	{
		if(struct_exists(next_anim, key[i]))
		{
			next_anim = struct_get(next_anim, key[i]);
			i++;
		}
		else
		{
			break;
		}
	}
	
	// If the length is equal to the intended length of the key, return the animation
	if(i == array_length(key))
	{
		return next_anim;
	}
	else // Otherwise no animation matches the key so return undefined
	{
		return undefined;
	}
}