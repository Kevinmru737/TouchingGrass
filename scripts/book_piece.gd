extends Area2D

var dragging = false
var drag_offset = Vector2.ZERO
var draggable = false
var placed = false
static var any_dragging = false

@export var correct_slot: NodePath
@onready var parent = $"../../../.."

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta):
	if dragging and not placed:
		global_position = get_global_mouse_position() + drag_offset

func _input(event):
	if placed:
		return

	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and not any_dragging:
			var mouse_pos = get_global_mouse_position()
			if draggable:
				dragging = true
				any_dragging = true
				drag_offset = global_position - mouse_pos

		elif not event.pressed:
			if dragging:
				dragging = false
				any_dragging = false
				check_slot()

func check_slot():
	var slot = get_node(correct_slot)
	if overlaps_area(slot):
		global_position = slot.global_position
		placed = true
		draggable = false
		input_pickable = false
		parent.on_book_placed()

func _on_mouse_entered() -> void:
	if not placed:
		draggable = true

func _on_mouse_exited() -> void:
	if not placed:
		draggable = false
