shader_type canvas_item;

uniform vec2 player_position;   // Set this from script each frame (global coordinates)
uniform float fade_distance = 10.0;
uniform float min_alpha = 0.3;
uniform vec2 box_size = vec2(100.0, 100.0); // Set this to size.x, size.y or pass from script

void fragment() {
    // The box starts at (0,0) in local coordinates and extends to box_size
    // Convert player_position from global to local if necessary, or pass local coords

    // For global coordinate use, get the global position of the control in script and subtract it from player_position before sending to this uniform
    vec2 local_player = player_position;

    // Calculate distances from player to each side
    float dx = max(0.0, max(0.0 - local_player.x, local_player.x - box_size.x));
    float dy = max(0.0, max(0.0 - local_player.y, local_player.y - box_size.y));
    float dist = (dx > 0.0 && dy > 0.0) ? length(vec2(dx, dy)) : max(dx, dy);

    float t = clamp(dist / fade_distance, 0.0, 1.0);
    float alpha = mix(min_alpha, 1.0, t);

    COLOR.a *= alpha;
}
