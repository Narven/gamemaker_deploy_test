if (!debug)
{
	exit;	
}

show_debug_overlay(!is_debug_overlay_open(), false, 1, 1.0);

if(!is_debug_overlay_open())
{
	window_set_cursor(cr_none);
}
else
{
	window_set_cursor(cr_default);	
}