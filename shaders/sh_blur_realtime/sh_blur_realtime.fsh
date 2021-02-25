varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform vec2 blur_vector;
uniform vec2 texel_size;

void main()
{
   highp vec4 blurred_col;
   vec2 offset_factor = texel_size * blur_vector;

   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord - 11.4139097 * offset_factor) * 0.0195697;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord - 9.4286565 * offset_factor) * 0.0367589;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord - 7.4435312 * offset_factor) * 0.0612333;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord - 5.4585077 * offset_factor) * 0.0904613;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord - 3.4735597 * offset_factor) * 0.1185196;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord - 1.4886598 * offset_factor) * 0.1377120;

   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord) * 0.0714907;

   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord + 1.4886598 * offset_factor) * 0.1377120;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord + 3.4735597 * offset_factor) * 0.1185196;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord + 5.4585077 * offset_factor) * 0.0904613;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord + 7.4435312 * offset_factor) * 0.0612333;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord + 9.4286565 * offset_factor) * 0.0367589;
   blurred_col += texture2D(gm_BaseTexture, v_vTexcoord + 11.4139097 * offset_factor) * 0.0195697;

   gl_FragColor = v_vColour * blurred_col;
}