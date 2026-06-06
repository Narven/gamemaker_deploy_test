if (!debug)
{
	exit;	
}

show_debug_message("LOG @ " + string(current_time));

show_debug_message("DELTA TIME\n" + string(delta_time) + "\n****************");


debug_event("ResourceCounts");