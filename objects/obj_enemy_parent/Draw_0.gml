// If the enemy was hurt this frame, make it flash white through the shader
if(hurt_time > 0) 
{
	shader_set(sh_whiteout);
}

// Draw the enemy
draw_self();

// Make sure the shader was reset and reset the tracker
if(hurt_time > 0) 
{
	hurt_time -= global.timer_delta * 0.000001;
	shader_reset();
}