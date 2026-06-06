// Updated the effect parameter with value
fx_set_parameter(set_fx, "g_VignetteEdges", [value_a * effect_strength, value_b * effect_strength]);
fx_set_parameter(set_fx, "g_VignetteSharpness", value_c * effect_strength);

// If the hit intensity is above zero, make the vignette red
if (hit_cooldown > 0)
{
	current_vignette_state = VIGNETTE_STATE.RED;
}
else if (shot_cooldown > 0) // Otherwise, if the shot intensity is above zero, make the vignette white
{
	current_vignette_state = VIGNETTE_STATE.WHITE;
}
else // Otherwise, just make it black
{
	current_vignette_state = VIGNETTE_STATE.BLACK;
}

// Match the vignette's colour
switch (current_vignette_state)
{
	case VIGNETTE_STATE.BLACK:
		fx_set_parameter(set_fx, "g_VignetteTexture", spr_txr_black);	
		break;
	case VIGNETTE_STATE.WHITE:
		fx_set_parameter(set_fx, "g_VignetteTexture", spr_txr_grey);	
		break;
	case VIGNETTE_STATE.RED:
		fx_set_parameter(set_fx, "g_VignetteTexture", spr_txr_red);	
		break;
}

// Decrease the shot intensity back to 0
if (shot_cooldown > 0)
{
	shot_cooldown -= global.update_time;
}

// Decrease the hit intensity back to 0
if (hit_cooldown > 0)
{
	hit_cooldown -= global.update_time;
}

// Lerp the effect strength towards 1
effect_strength = lerp(effect_strength, 1.0, 0.15);