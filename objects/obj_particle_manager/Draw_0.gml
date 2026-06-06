 if (is_render_scaled && !late_draw)
{
	var _world = matrix_get(matrix_world);
	var _view = matrix_get(matrix_view);
	var _proj = matrix_get(matrix_projection);
	
	var sclmat = matrix_build_identity();
	
	sclmat[0]  = render_scale;
	sclmat[5]  = render_scale;
	sclmat[10] = 1.0;
	
	matrix_set(matrix_world, sclmat);	
		
	part_system_position(particle_sys, x / render_scale, y / render_scale);
	part_system_drawit(particle_sys); 
	
	matrix_set(matrix_world, _world);
	matrix_set(matrix_view, _view);
	matrix_set(matrix_projection, _proj);
}