extends Area2D

var draggable = false
@onready var parent = $".."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if draggable and Input.is_action_pressed("click"):
		parent.global_position = get_global_mouse_position()
	elif Input.is_action_just_released("click"):
		print("bruh")

func _on_mouse_entered() -> void:
	draggable = true # Replace with function body.


func _on_mouse_exited() -> void:
	draggable = false # Replace with function body.
