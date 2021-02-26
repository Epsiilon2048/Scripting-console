
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
varying vec3 v_vPosition;
//
uniform vec4 u_bounds;
//
void main() {
    vec4 col = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    col.a *= float(v_vPosition.x >= u_bounds[0] && v_vPosition.y >= u_bounds[1]
        && v_vPosition.x < u_bounds[2] && v_vPosition.y < u_bounds[3]);
    gl_FragColor = col;
}