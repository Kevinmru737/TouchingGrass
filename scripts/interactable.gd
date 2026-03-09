extends Area2D

@export var object_name: String = "Fish Tank"
#@onready var backglow = $Backglow
@onready var cursor = load("res://art/smallerfish.png")
func _ready():
	#backglow.modulate.a = 0  # Start invisible
	pass

func _on_mouse_entered():
	HoverManager.on_hovered(self)
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(0, 0))
	#var tween = create_tween()
	#tween.tween_property(backglow, "modulate:a", 1.0, 0.3)
	# Optional: scale up for radiating effect
	#tween.parallel().tween_property(backglow, "scale", Vector2(1.3, 1.3), 0.3)


func _on_mouse_exited():
	HoverManager.on_unhovered(self)
	Input.set_custom_mouse_cursor(null)
	#var tween = create_tween()
	#tween.tween_property(backglow, "modulate:a", 0.0, 0.3)
	#tween.parallel().tween_property(backglow, "scale", Vector2(1.0, 1.0), 0.3)
