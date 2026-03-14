extends Area2D

var clickable = false


func _ready():
	$Sprite2D.modulate.a = 0.7
	$Light.modulate.a = 0.6
	self.hide()
	
func _process(_float):
	if Input.is_action_just_pressed("click") and clickable:
		$"..".go_outside()

func _on_mouse_entered() -> void:
	$Light.modulate.a = 0.7
	$Sprite2D.modulate.a = 0.9
	clickable = true


func _on_mouse_exited() -> void:
	$Sprite2D.modulate.a = 0.7
	$Light.modulate.a = 0.6
	clickable = false
