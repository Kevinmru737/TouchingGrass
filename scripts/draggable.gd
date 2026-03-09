extends Area2D

var hovering = false
var dragging = false
var drag_offset = Vector2.ZERO

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click") and hovering:
		dragging = true
		drag_offset = global_position - get_global_mouse_position()
		
	
	if Input.is_action_just_released("click"):
		dragging = false
	
	if dragging:
		global_position = get_global_mouse_position() + drag_offset

func _on_mouse_entered() -> void:
	hovering = true
	print("this is fishy")

func _on_mouse_exited() -> void:
	hovering = false
