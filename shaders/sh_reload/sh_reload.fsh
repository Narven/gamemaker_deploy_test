//
// Draw the regular texture but draw any point past a percentage of the x axis a bit more transparent than the rest
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float mag_percentage;
uniform vec4 sprite_uvs;

void main()
{
	float x_percentage = (v_vTexcoord.x - sprite_uvs.x) / (sprite_uvs.y - sprite_uvs.x);
	float y_percentage = (v_vTexcoord.y - sprite_uvs.z) / (sprite_uvs.w - sprite_uvs.z);
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	
	if(x_percentage - 0.02 + y_percentage / 16.0 > mag_percentage)
	{
		gl_FragColor.a = 0.2 * gl_FragColor.a;
	}
}
