// Make sure there is a manager still attached or being used
if (instance_exists(owner))
{
	// Increase the blur alpha and lock controls
	blocker_alpha += in_rate * global.timer_delta * 0.000001;
	global.is_controls_locked = true;
	
	with (obj_ui_splash_button_parent)
	{
		image_alpha = 1 - obj_effect_overlay.blocker_alpha;
	}
}
else // Otherwise lower the alpha and give controls back
{
	blocker_alpha -= out_rate * global.timer_delta * 0.000001;
	global.is_controls_locked = false;
	
	with (obj_ui_splash_button_parent)
	{
		image_alpha = 1 - obj_effect_overlay.blocker_alpha;
	}
	
	// When the blur alpha hits 0, destroy this object
	if (blocker_alpha <= 0)
	{
		instance_destroy();	
	}
}

// Clamp the blur alpha
blocker_alpha = clamp(blocker_alpha, 0, 1);

// Based on the blur type, enact different blurs
if (blocker_alpha > 0)
{
	var _calc_alpha = smoothstep(0, 1, blocker_alpha);
	
	switch(current_blur_type)
	{
		case BLUR_TYPE.BLUR:
			fx_set_parameter(set_fx, "g_numPasses", _calc_alpha * 6);
		break;
		
		case BLUR_TYPE.FROSTED:
			fx_set_parameter(set_fx, "g_Radius", _calc_alpha * 10);
		break;
		
		case BLUR_TYPE.DARKEN:
			fx_set_parameter(set_fx, "g_TintCol", [1 - _calc_alpha * 1.0, 1 - _calc_alpha * 1.0, 1 - _calc_alpha * 1.0, _calc_alpha]);
		break;
		
		case BLUR_TYPE.DESATURATE:
			fx_set_parameter(set_fx, "g_Intensity", _calc_alpha);
		break;
		
		case BLUR_TYPE.ZOOM:
			fx_set_parameter(set_fx, "g_ZoomBlurIntensity", _calc_alpha * 0.05);
		break;
		
		case BLUR_TYPE.PIXELATE:
		{
			_calc_alpha = max(_calc_alpha, 0.01);	// a cell size of 0 will cause NaNs in the pixelate fragment shader
			fx_set_parameter(set_fx, "g_CellSize", _calc_alpha * 20);
		}
		break;
		
		case BLUR_TYPE.NONE:
		break;
	}
}