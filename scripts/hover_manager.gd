extends Node

var label: Label
var current_hovered = null

func _ready():
	label = Label.new()
	label.visible = false
	get_tree().root.call_deferred("add_child", label)

func _process(_delta):
	#if label.visible:
	#	label.global_position = get_viewport().get_mouse_position() + Vector2(16, -24)
	pass

func on_hovered(interactable):
	current_hovered = interactable
	#label.text = interactable.object_name
	#print(interactable)
	#label.visible = true
	pass

func on_unhovered(_interactable):
	current_hovered = null
	#label.visible = false
	pass
