varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec3 bl_size; //Width, Height, Radius
uniform int bl_quality; //Blur Quality
uniform int bl_directions; //Directions to blur

const float pi2 = 6.28318530718; //pi*2

void main()
{
	vec2 radius = bl_size.z / bl_size.xy;
	vec4 Color = texture2D(gm_BaseTexture, v_vTexcoord);
	for (float d = 0.0; d < pi2; d += pi2 / float(bl_directions))
	{
		for (float i = 1.0 / float(bl_quality); i <= 1.0; i += 1.0 / float(bl_quality))
		{
			Color += texture2D( gm_BaseTexture, v_vTexcoord + vec2(cos(d),sin(d)) * radius * i);
		}
	}
	Color /= float(bl_quality) * float(bl_directions) + 1.0;
	gl_FragColor =  Color * v_vColour;
}