// Checks if the set sequence exists
if (set_sequence != -1)
{
	// Destroys the sequence
	layer_sequence_destroy(set_sequence);
}

// Checks if the manager is self cleaning
if (is_self_cleaning)
{
	if (layer_exists(layer))
	{
		// Destroys this layer
		layer_destroy(layer);	
	}
}