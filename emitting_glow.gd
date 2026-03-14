extends CPUParticles2D
@onready var particles = self

func _ready():
	particles.emitting = true
	particles.amount = 200
	particles.lifetime = 2.0
	particles.emission_shape = CPUParticles2D.EMISSION_SHAPE_POINT
	
	# Spread across a half circle (upward)
	particles.spread = 90.0          # 180° total spread = half circle
	particles.direction = Vector2(0, -1)  # emit upward
	
	# Dispersion: grow apart over time
	particles.initial_velocity_min = 80.0
	particles.initial_velocity_max = 200.0
	
	# Fade as they travel
	var gradient = Gradient.new()
	gradient.set_color(0, Color.WHITE)
	gradient.set_color(1, Color(1, 1, 1, 0))
	particles.color_ramp = gradient
	
	# Shrink over time
	particles.scale_amount_min = 1.0
	particles.scale_amount_max = 1.0
	particles.scale_amount_curve = make_shrink_curve()

func make_shrink_curve() -> Curve:
	var c = Curve.new()
	c.add_point(Vector2(0, 1))
	c.add_point(Vector2(1, 0.1))
	return c
