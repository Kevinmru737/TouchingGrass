extends Area2D

@export var object_name: String = "Object"
@export var minigame_scene: PackedScene

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pass

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if HoverManager.current_hovered == self:
				if minigame_scene:
					get_tree().current_scene.add_child(minigame_scene.instantiate())

func _on_mouse_entered():
	HoverManager.on_hovered(self)

func _on_mouse_exited():
	HoverManager.on_unhovered(self)
	
