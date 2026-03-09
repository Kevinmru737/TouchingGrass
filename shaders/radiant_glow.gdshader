shader_type canvas_item;

uniform vec4 glow_color = vec4(1.0, 1.0, 0.5, 1.0);
uniform float intensity = 0.6;
uniform float radius = 0.4;
uniform float softness = 0.1;  // Controls how soft the edge is

void fragment() {
	vec2 center = vec2(0.5, 0.5);
	float dist = length(UV - center);
	
	// Soft circular gradient
	float circle = smoothstep(radius + softness, radius - softness, dist);
	
	COLOR = glow_color;
	COLOR.a = circle * intensity;
}