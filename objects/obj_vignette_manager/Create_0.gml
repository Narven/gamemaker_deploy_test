// Create the different states/colours the vignette can be in
enum VIGNETTE_STATE
{
	BLACK,
	WHITE,
	RED,
	SIZE
}

current_vignette_state = VIGNETTE_STATE.BLACK;

// Store the intensities of the vignette due to shooting or being shot as timers to allow timer manipulation
shot_cooldown = 0;
hit_cooldown = 0;

// Variable for storing the effect to
set_fx = -1;

// Variable for the effects stregth
effect_strength = 1.0;

// Values for vignette
value_a = 0.9; // Edges 1
value_b = 1.6; // Edges 2
value_c = 2.0; // Shapness

// Function used to update the effect based on the type set
update_filter = function()
{
	// Checks for the effects layer
	if (layer_get_fx("Vignette") != -1)
	{
		// Clears the effects later
	    layer_clear_fx("Vignette");
	}
	
	// Creates effect
	set_fx = fx_create("_filter_vignette");
	
	// Sets the effect parameters
	fx_set_parameter(set_fx, "g_VignetteEdges", [value_a, value_b]);
	
	fx_set_parameter(set_fx, "g_VignetteSharpness", value_c * effect_strength);
	
	fx_set_parameter(set_fx, "g_VignetteTexture", spr_txr_black);
	
	// Sets the effect to the layer
	layer_set_fx("Vignette", set_fx);
}

// Calls the update filter function created
update_filter();