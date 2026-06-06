//
// Draw the regular texture, but at any point past a certain x percentage, instead draw the housing texture
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D background;
uniform float hp_point;
uniform vec4 bar_uvs;
uniform vec4 back_uvs;

void main()
{
	float x_percentage = (v_vTexcoord.x - bar_uvs.x) / (bar_uvs.y - bar_uvs.x);
	float y_percentage = (v_vTexcoord.y - bar_uvs.z) / (bar_uvs.w - bar_uvs.z);
	
	vec2 back_tex_coord = vec2(
		back_uvs.x + x_percentage * (back_uvs.y - back_uvs.x), 
		back_uvs.z + y_percentage * (back_uvs.w - back_uvs.z)
	);
	
	if(x_percentage + y_percentage / 18.0 <= hp_point)
	{
		gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord);
	}
	else
	{
		gl_FragColor = v_vColour * texture2D( background, back_tex_coord );
	}
}
