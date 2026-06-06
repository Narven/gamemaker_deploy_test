// Store how wide and tall each surface should be
surface_width = 256;
surface_height = 256;

// A source surface to initially draw to. Only one is needed
surf_source = surface_create(surface_width, surface_height);

// Array of surfaces to draw the text to
surf_destination = [surface_create(surface_width, surface_height)];

// Function to create a surface with text drawn skewed on it
function create_text_skewed(_text, _skew_angle, _alpha, _font, _is_surface = false, _id = 0)
{
	// Set up the draw variables for text and blending
	gpu_set_blendmode(bm_add);
	
	draw_set_font(_font);
	draw_set_valign(fa_middle);
	draw_set_halign(fa_center);
	
	// Draw the original text
	if!(surface_exists(surf_source))
	{
		surf_source = surface_create(surface_width, surface_height);
	}
		
	surface_set_target(surf_source);
	draw_clear_alpha(c_black, 0);
	
	draw_text(surface_width / 2, surface_height / 2, _text);
	
	surface_reset_target();
	
	while (_id >= array_length(surf_destination))
	{
		array_push(surf_destination, surface_create(surface_width, surface_height));
	}
	
	if (!surface_exists(surf_destination[_id]))
	{
		surf_destination[_id] = surface_create(surface_width, surface_height);
	}
	
	// Draw the text skewed
	surface_set_target(surf_destination[_id]);
	draw_clear_alpha(c_black, 0);
	
	// Draw the source surface skewed
	draw_primitive_begin_texture(pr_trianglestrip, surface_get_texture(surf_source));
	
	draw_vertex_texture(0,				(surface_width * sin(degtorad(_skew_angle))),					0, 0);
	draw_vertex_texture(surface_width,	-(surface_width * sin(degtorad(_skew_angle))),					1, 0);
	draw_vertex_texture(0,				surface_height + (surface_width * sin(degtorad(_skew_angle))),	0, 1);
	draw_vertex_texture(surface_width,	surface_height - (surface_width * sin(degtorad(_skew_angle))),	1, 1);
	
	draw_primitive_end();

	surface_reset_target();
	
	// Clean up and render out
	draw_set_valign(fa_top);
	draw_set_halign(fa_left);
	
	// Reset the blend mode
	gpu_set_blendmode(bm_normal);
	
	// Return the surface/sprite
	if (_is_surface)
	{
		return surf_destination[_id];
	}
	else
	{
		return sprite_create_from_surface(surf_destination[_id], 0, 0, surface_width, surface_height, true, false, surface_width / 2, surface_height / 2);
	}
}