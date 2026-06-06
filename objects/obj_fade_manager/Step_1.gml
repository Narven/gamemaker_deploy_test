// Carry out different functionality based on what the fade manager is currently doing
switch(fade_state)
{
	// If fading in, reduce the fade amount over time and once it reaches zero, return to idle
	case fade_states.IN:
		fade_amount -= global.timer_delta * 0.000001 / (fade_time / 2);
		if(fade_amount <= 0)
		{
			fade_amount = 0;
			fade_state = fade_states.IDLE;
			global.is_fading = false;
		}
		break;
	// If fading out, increase the fade amount over time and once it reaches 1, perform the post fade behaviour and start to fade in
	case fade_states.OUT:
		fade_amount += global.timer_delta * 0.000001 / (fade_time / 2);
		if(fade_amount >= 1)
		{
			post_fade_behaviour();
			fade_amount = 1;
			fade_state = fade_states.IN;
		}
		break;
	// In all other cases, do nothing.
	default:
	case fade_states.IDLE:
		break;
}

var _bowser_width = browser_width;
var _bowser_height = browser_height;

// Check if html5
if (os_browser != browser_not_a_browser && os_type != os_gxgames) 
{
    if (_bowser_width != room_width * render_scale_width || _bowser_height != room_height * render_scale_height) 
    { 
        render_scale_width = room_width / _bowser_width;
        render_scale_height = room_height / _bowser_height;
        
        render_scale = max(render_scale_width, render_scale_height);
        
        window_set_size(room_width / render_scale, room_height / render_scale);
    
        display_set_gui_size(room_width, room_height);
    }
}