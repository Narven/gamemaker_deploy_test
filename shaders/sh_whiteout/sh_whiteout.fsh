//
// Draw the regular texture but replace the colour values with white
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord );
	gl_FragColor.xyz = vec3(1.0, 1.0, 1.0);
}
