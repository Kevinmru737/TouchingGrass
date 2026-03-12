extends Area2D

#@onready var backglow = $Backglow
@onready var cursor = load("res://art/placeholders/smallerfish.png")
@export var object_name: String = "Object"
@export var minigame_scene: PackedScene

signal interact_initiated 

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if HoverManager.current_hovered == self:
				interact_initiated.emit(self.get_parent().name)

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
	
func start_minigame():
	if minigame_scene:
		get_tree().current_scene.add_child(minigame_scene.instantiate())
