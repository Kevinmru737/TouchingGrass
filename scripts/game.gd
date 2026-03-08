extends Node


@onready var dialogue_ui = $DialogueUI



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dialogue_ui.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("click"):
		#dialogue_ui.show()
		dialogue_ui.process_dialogue("intro")
