// Owner ui menu or overlay
owner = -1;

// Blur types
enum BLUR_TYPE
{
	BLUR,
	FROSTED,
	DARKEN,
	DESATURATE,
	ZOOM,
	PIXELATE,
	NONE,
	SIZE
}

// Current blur type
current_blur_type = BLUR_TYPE.NONE;

// Current blur alpha
blocker_alpha = 0.0;

// The effect created
set_fx = -1;

// Rate of effect in and out
in_rate = 6.4;
out_rate = 3.2;

// Function to transition into and out of screen effects
update_filter = function()
{
	if (layer_get_fx("Screen_Effects") != -1)
	{
	    layer_clear_fx("Screen_Effects");
	}

	var _calc_alpha = smoothstep(0, 1, blocker_alpha);
	
	switch(current_blur_type)
	{
		case BLUR_TYPE.BLUR:
	
			set_fx = fx_create("_effect_gaussian_blur");
			fx_set_parameter(set_fx, "g_numDownsamples", 1);
			fx_set_parameter(set_fx, "g_numPasses", _calc_alpha * 6);
			layer_set_fx("Screen_Effects", set_fx);
	
		break;
		case BLUR_TYPE.FROSTED:
		
			set_fx = fx_create("_filter_large_blur");
			fx_set_parameter(set_fx, "g_Radius", _calc_alpha * 4);
			layer_set_fx("Screen_Effects", set_fx);
	
		break;
		case BLUR_TYPE.DARKEN:
	
			set_fx = fx_create("_filter_tintfilter");
			fx_set_parameter(set_fx, "g_TintCol", [1 - _calc_alpha * 1.0, 1 - _calc_alpha * 1.0, 1 - _calc_alpha * 1.0, _calc_alpha]);
			layer_set_fx("Screen_Effects", set_fx);
		
		break;
		case BLUR_TYPE.DESATURATE:
		
			set_fx = fx_create("_filter_greyscale");
			fx_set_parameter(set_fx, "g_Intensity", _calc_alpha);
			layer_set_fx("Screen_Effects", set_fx);
			
		break;
		case BLUR_TYPE.ZOOM:
			
			set_fx = fx_create("_filter_zoom_blur");
			fx_set_parameter(set_fx, "g_ZoomBlurIntensity", _calc_alpha * 0.05);
			layer_set_fx("Screen_Effects", set_fx);
		
		break;
		case BLUR_TYPE.PIXELATE:
			set_fx = fx_create("_filter_pixelate");
			_calc_alpha = max(_calc_alpha, 0.01);	// a cell size of 0 will cause NaNs in the pixelate fragment shader
			fx_set_parameter(set_fx, "g_CellSize", _calc_alpha * 20);
			layer_set_fx("Screen_Effects", set_fx);
		break;
		case BLUR_TYPE.NONE:
		break;
	}	
}

// Function for setting owner
set_owner = function(_owner, _type = BLUR_TYPE.FROSTED)
{
	// Owner set from arg
	owner = _owner;
	
	current_blur_type = _type;
	
	update_filter();
}