// Checks if has a death call
if (has_death)
{
	// Runs the death call
	stored_function();	
}

// Destroys particle system
part_system_destroy(particle_sys);

// Checks if paricle self cleans its layer
if (is_layer_cleaned)
{
	if (layer_exists(layer))
	{
        // Check if not html5
        if (!global.is_html5)
        {
    		// Destroys this layer
    		layer_destroy(layer);	
        }
	}
}