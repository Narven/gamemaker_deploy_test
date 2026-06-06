//Chrome mobile will block fullscreen request if not in a touch event, restore it here
if(os_type==os_operagx)
{
	if(fullscreen)
	{
		if(window_get_fullscreen()==0)
		{
			window_set_size(display_get_width(),display_get_height());
			window_set_fullscreen(fullscreen);
			show_debug_message("Entering main loop."); //Hack fix for 2024.13, forces ensureAspectRatio to be called
		}
	}
	if(display_get_orientation()!=orientation)
	{
		orientation = display_get_orientation();
		window_set_size(display_get_width(),display_get_height());
		window_set_fullscreen(fullscreen);
		show_debug_message("Entering main loop.");
	}
}		