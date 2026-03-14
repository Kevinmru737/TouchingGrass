extends ColorRect

func _ready():
	# Size it to your needs
	size = Vector2(600, 400)
	
	var shader = load("res://glow.gdshader")
	var mat = ShaderMaterial.new()
	mat.shader = shader
	material = mat
	
	# Make sure the ColorRect itself is transparent
	color = Color.TRANSPARENT
