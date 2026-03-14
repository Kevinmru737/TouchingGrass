shader_type canvas_item;

void fragment() {
    vec2 uv = UV;
    
    // Origin at bottom center
    vec2 origin = vec2(0.5, 1.0);
    vec2 dir = uv - origin;
    
    float dist = length(dir);
    
    // Only show upper half
    float half_mask = step(uv.y, 1.0);
    
    // Intensity layers matching the visual
    float outer = pow(max(0.0, 1.0 - dist / 0.85), 1.8);
    float mid   = pow(max(0.0, 1.0 - dist / 0.50), 2.2);

    
    float glow = outer * 0.45 + mid * 0.9 * 1.0;
    glow = clamp(glow, 0.0, 1.0);
    glow *= half_mask;
    
    COLOR = vec4(1.0, 1.0, 1.0, glow);
}
