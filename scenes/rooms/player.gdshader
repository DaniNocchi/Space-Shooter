shader_type canvas_item;

uniform float horizontal_influence: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float vertical_influence: hint_range(0.0, 1.0, 0.1) = 0.5;
uniform float strength: hint_range(0.0, 1.0, 0.05) = 0.3;
uniform float speed: hint_range(-5.0, 5.0, 0.1) = 1.0; // slide speed (+/-)

vec3 hsv2rgb(vec3 _c) {
    vec4 _K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 _p = abs(fract(_c.xxx + _K.xyz) * 6.0 - _K.www);
    return _c.z * mix(_K.xxx, clamp(_p - _K.xxx, 0.0, 1.0), _c.y);
}

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float t = TIME * speed;
    // Offset UVs by time so the gradient slides
    vec2 uv_moving = UV + vec2(t, 0.0); // slide horizontally; change to vec2(0.0, t) for vertical

    vec3 rainbow =
        horizontal_influence * hsv2rgb(vec3(fract(uv_moving.x), 1.0, 1.0)) +
        vertical_influence   * hsv2rgb(vec3(fract(uv_moving.y), 1.0, 1.0));

    COLOR.rgb = mix(tex.rgb, rainbow, strength);
    COLOR.a   = tex.a * 1.0;
}
