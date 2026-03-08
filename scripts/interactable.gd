extends Area2D

@export var object_name: String = "Fish Tank"

func _ready():
	#mouse_entered.connect(_on_mouse_entered)
	#mouse_exited.connect(_on_mouse_exited)
	pass

func _on_mouse_entered():
	HoverManager.on_hovered(self)

func _on_mouse_exited():
	HoverManager.on_unhovered(self)
