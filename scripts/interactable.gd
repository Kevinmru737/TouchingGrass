extends Area2D

@export var object_name: String = "Fish Tank"

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _on_mouse_entered():
	hover_manager.on_hovered(self)

func _on_mouse_exited():
	hover_manager.on_unhovered(self)
