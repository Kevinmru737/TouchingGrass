extends Area2D

<<<<<<< HEAD
@export var object_name: String = "Fish Tank"
#@onready var backglow = $Backglow
@onready var cursor = load("res://art/smallerfish.png")
func _ready():
	#backglow.modulate.a = 0  # Start invisible
=======
@export var object_name: String = "Object"
@export var minigame_scene: PackedScene

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
>>>>>>> c33a60ec45c0e48a55e742a463bf3c4e0c0ae3f3
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if HoverManager.current_hovered == self:
				if minigame_scene:
					get_tree().current_scene.add_child(minigame_scene.instantiate())

func _on_mouse_entered():
	HoverManager.on_hovered(self)
	Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(0, 0))
	#var tween = create_tween()
	#tween.tween_property(backglow, "modulate:a", 1.0, 0.3)
	# Optional: scale up for radiating effect
	#tween.parallel().tween_property(backglow, "scale", Vector2(1.3, 1.3), 0.3)


func _on_mouse_exited():
	HoverManager.on_unhovered(self)
<<<<<<< HEAD
	Input.set_custom_mouse_cursor(null)
	#var tween = create_tween()
	#tween.tween_property(backglow, "modulate:a", 0.0, 0.3)
	#tween.parallel().tween_property(backglow, "scale", Vector2(1.0, 1.0), 0.3)
=======
	
>>>>>>> c33a60ec45c0e48a55e742a463bf3c4e0c0ae3f3
