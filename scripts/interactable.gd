extends Area2D

#@onready var backglow = $Backglow
@onready var cursor = load("res://art/misc/Cursor_Interact.png")
@export var object_name: String = "Object"
@export var minigame_scene: PackedScene
@onready var dark_sprite = $DarkVersion
@onready var bright_sprite = $BrightVersion

# interacted_with_flags

var bed_success_flag = false
var fishtank_success_flag = false
var musicplayer_success_flag = false
var bookshelf_success_flag = false
var trashcan_success_flag = false


signal interact_initiated 

func _ready():
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	bright_sprite.hide()

func _unhandled_input(event: InputEvent) -> void:
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
		
func success_interact():
	var curr_flag_name = self.name.to_lower() + "_success_flag"
	
	# Get the actual flag variable
	if not get(curr_flag_name):
		var tween = get_tree().create_tween()
		dark_sprite.modulate.a = 1.0
		bright_sprite.modulate.a = 0.0
		bright_sprite.show()
		
		tween.tween_property(dark_sprite, "modulate:a", 0.0, 0.5)
		tween.parallel().tween_property(bright_sprite, "modulate:a", 1.0, 0.5)
		
		# Set the flag to true
		set(curr_flag_name, true)
