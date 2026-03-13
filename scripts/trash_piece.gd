extends Area2D

var dragging = false
var drag_offset = Vector2.ZERO
var draggable = false
static var any_dragging = false
@onready var parent = $"../../../.."

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	
func _process(_delta):
	if dragging:
		global_position = get_global_mouse_position() + drag_offset
		
func _input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not any_dragging:
			var mouse_pos = get_global_mouse_position()
			#var distance = global_position.distance_to(mouse_pos)
			if draggable:
				dragging = true
				any_dragging = true
				drag_offset = global_position - mouse_pos
		elif not event.pressed:
			if dragging:
				dragging = false
				any_dragging = false
				check_trashcan()

func check_trashcan():
	var trashcan = get_parent().get_node("Trashcan")
	if overlaps_area(trashcan):
		parent.on_trash_disposed()
		queue_free()


func _on_mouse_entered() -> void:
	draggable = true
	
func _on_mouse_exited() -> void:
	draggable = false
